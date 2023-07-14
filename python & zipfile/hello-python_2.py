def lambda_handler(event, context):
    for record in event['Records']:
      body = record['body']
      print("From SQS: " + body)