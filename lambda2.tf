data "archive_file" "zip_the_python_code_2" {
  type        = "zip"
  source_file  = "${path.module}/python & zipfile/hello-python_2.py"
  output_path = "${path.module}/python & zipfile/hello-python_2.zip"
}


resource "aws_lambda_function" "terraform_lambda_func_2" {
  filename      = "${path.module}/python & zipfile/hello-python_2.zip"
  function_name = "Lambda-Function_2"
  role          = aws_iam_role.lambda_role.arn
  handler       = "hello-python_2.lambda_handler"
  runtime       = "python3.10"
  depends_on    = [aws_iam_role_policy_attachment.sqs_attachment]

  environment {
    variables = {
      QUEUE_URL = aws_sqs_queue.queue.url
    }
  }
}