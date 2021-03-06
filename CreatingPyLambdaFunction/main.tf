resource "aws_iam_role" "helloworld_role" {
    name = "helloworld_role"
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

# AWS Lambda function
resource "aws_lambda_function" "helloworld" {
    filename         = "helloworld.zip"
    function_name    = "helloWorld"
    role             = "${aws_iam_role.helloworld_role.arn}"
    handler          = "helloWorld.lambda_handler"
    runtime          = "python2.7"
    timeout          = 3
    source_code_hash = "${base64sha256(file("helloworld.zip"))}"
}
