import requests
import boto3
import os

def lambda_handler(event, context):
    
    # Make a GET request to the ReqRes API
    response = requests.get('https://reqres.in/api/users?page=2')
    
    # Check if the request was successful (status code 200)
    if response.status_code == 200:
        # Get the response body
        response_body = response.json()
        
        # Create an SQS client
        sqs = boto3.client('sqs')
        queue_url = os.environ["QUEUE_URL"]
        sqs.send_message(
            QueueUrl=queue_url,
            MessageBody=str(response_body)
            )
        return {
                'statusCode': 200,
                'body': 'Request sent to ReqRes API and message sent to the queue.'
                
            }
