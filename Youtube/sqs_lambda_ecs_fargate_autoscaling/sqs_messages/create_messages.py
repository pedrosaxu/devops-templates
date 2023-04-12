import boto3

aws_cli_profile = 'default'
region = 'us-east-1'
proccess_queue_name='sqs-proccess-queue'
appname='sensor-ssl'

session = boto3.Session(profile_name=aws_cli_profile)

sqs = boto3.client('sqs')
sts = boto3.client("sts")
account_id = sts.get_caller_identity()["Account"]

queue_url = (f'https://sqs.{region}.amazonaws.com/{account_id}/{proccess_queue_name}')

# Send message to SQS queue
response = sqs.send_message(
    QueueUrl=queue_url,
    DelaySeconds=10,
    MessageAttributes={
        'Attribute_2': {
            'DataType': 'String',
            'StringValue': 'Foo'
        },
        'Attribute_1': {
            'DataType': 'String',
            'StringValue': 'Baaz'
        }
    },
    MessageBody=(
        {"appname": [appname]}
    )
)

print(response['MessageId'])