import boto3

aws_cli_profile = 'default'
region = 'us-east-1'
proccess_queue_name='sqs-proccess-queue'

session = boto3.Session(profile_name=aws_cli_profile)

sqs = boto3.client('sqs')
sts = boto3.client("sts")
account_id = sts.get_caller_identity()["Account"]

queue_url = (f'https://sqs.{region}.amazonaws.com/{account_id}/{proccess_queue_name}')

# Receive message from SQS queue
response = sqs.receive_message(
    QueueUrl=queue_url,
    AttributeNames=[
        'SentTimestamp'
    ],
    MaxNumberOfMessages=1,
    MessageAttributeNames=[
        'All'
    ],
    VisibilityTimeout=0,
    WaitTimeSeconds=0
)

message = response['Messages'][0]
receipt_handle = message['ReceiptHandle']

# Delete received message from queue
sqs.delete_message(
    QueueUrl=queue_url,
    ReceiptHandle=receipt_handle
)
print('Received and deleted message: %s' % message)