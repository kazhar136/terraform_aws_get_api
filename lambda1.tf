data "archive_file" "zip_the_python_code" {
  type        = "zip"
  source_file  = "${path.module}/python & zipfile/hello-python.py"
  output_path = "${path.module}/python & zipfile/hello-python.zip"
}


resource "aws_lambda_function" "terraform_lambda_func" {
  filename      = "${path.module}/python & zipfile/hello-python.zip"
  function_name = "Lambda-Function_1"
  role          = aws_iam_role.lambda_role.arn
  handler       = "hello-python.lambda_handler"
  runtime       = "python3.10"
  layers        = [aws_lambda_layer_version.my_layer.arn]
  depends_on    = [aws_iam_role_policy_attachment.sqs_attachment]

  
  environment {
    variables = {
      QUEUE_URL = aws_sqs_queue.queue.url
    }
  }

}