# Create an AWS SQS (Simple Queue Service) queue resource

resource "aws_sqs_queue" "queue" {
  name                      = var.queue_name
  delay_seconds             = var.delay_seconds
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10

  tags = {
    Environment = "production"
  }
}
# Lambda trigger for sqs
resource "aws_lambda_event_source_mapping" "sqs_msg" {
  event_source_arn = aws_sqs_queue.queue.arn
  function_name    = aws_lambda_function.terraform_lambda_func.arn
}
# Lambda2 trigger for sqs
resource "aws_lambda_event_source_mapping" "sqs_msg2" {
  event_source_arn = aws_sqs_queue.queue.arn
  function_name    = aws_lambda_function.terraform_lambda_func_2.arn
}
