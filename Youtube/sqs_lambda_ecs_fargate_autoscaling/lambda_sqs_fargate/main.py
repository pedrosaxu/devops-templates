import boto3
import json

def get_account_data():
    sts = boto3.client("sts")
    account_id = sts.get_caller_identity()["Account"]
    return account_id

def parse_initial_message(event):
    appname=json.loads(event['Records'][0]['body'])['appname'][0]
    return appname

def scale_ecs_service(region, appname, task_count, cluster, task_launch_type, task_subnets, task_sg, task_public_ip):
    ecs = boto3.client('ecs', region)

    # Get ECS task definition ARN
    task_describe = ecs.describe_task_definition(taskDefinition=f"{appname}")
    task_definition_arn = task_describe['taskDefinition']['taskDefinitionArn']

    # Create the task in the Fargate cluster
    response = ecs.run_task(
            taskDefinition=task_definition_arn,
            cluster=cluster,
            count=task_count,
            launchType=task_launch_type,
            networkConfiguration={
            'awsvpcConfiguration': {
                'subnets': task_subnets,
                'securityGroups': task_sg,
                'assignPublicIp': task_public_ip
            }
        },
    )
    
    # Return the task ARN(s) for downstream processing
    task_arns = [task['taskArn'] for task in response['tasks']]
    return task_arns
    
def reproccess_message(event, region, account_id, appname):
    # Initialize the AWS SDK client for SQS
    sqs = boto3.client('sqs')

    queue_url = (f'https://sqs.{region}.amazonaws.com/{account_id}/sqs-{appname}-queue')

    # Send message to SQS queue
    response = sqs.send_message(
        QueueUrl=queue_url,
        DelaySeconds=10,
        #MessageAttributes=(event['Records'][0]['messageAttributes']),
        MessageBody=(event['Records'][0]['body'])
    )
    
    return task_arns

def lambda_handler(event, context):

    # Global variables
    region = 'us-east-1'
    cluster = 'ClusterName'
    task_count = 1
    task_launch_type = 'FARGATE'
    task_subnets=['subnet-0314fc17e537bd8e5','subnet-09a2993f8fcd3d807']
    task_sg=['sg-006b2ef7d4ba82721']
    task_public_ip = 'ENABLED'

    account_id = get_account_data()
    appname = parse_initial_message(event)
    task_arns = scale_ecs_service(region, appname, task_count, cluster, task_launch_type, task_subnets, task_sg, task_public_ip)
    reprocessed_messages=reproccess_message(event, region, account_id, appname)
    
    return task_arns, reprocessed_messages