
resource "aws_iam_role" "lambda_role" {
  name = "iam_for_lambda"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "sqs_policy" {
  name        = "lambda_sqs_policy"
  description = "Policy for full access to SQS"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "sqs:*",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "cloudwatch_policy" {
  name        = "cloudwatch-full-access-policy"
  description = "Policy for full access to CloudWatch"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "logs:*",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "sqs_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.sqs_policy.arn
}

resource "aws_iam_role_policy_attachment" "cloudwatch_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.cloudwatch_policy.arn
}

