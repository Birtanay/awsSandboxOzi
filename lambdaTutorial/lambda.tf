resource "aws_lambda_function" "newpostlambda" {
    filename         = "newposts.zip"
    runtime = "python2.7"
    function_name = "PostReader_NewPost"
    role = "${aws_iam_role.LambdaPostReaderRole.arn}"
    handler = "newposts.lambda_handler"
    source_code_hash = "${base64sha256(file("code/newposts.zip"))}"
    environment {
        variables = {
            DB_TABLE_NAME = "${var.dbtablename}"
            SNS_TOPIC = "${aws_sns_topic.newposttopic.arn}"
        }
    }
}

resource "aws_lambda_function" "converttoaudiolambda" {
    filename         = "convertoaudio.zip"
    runtime = "python2.7"
    function_name = "PostReader_ConvertToAudio"
    role = "${aws_iam_role.LambdaPostReaderRole.arn}"
    handler = "convertoaudio.lambda_handler"
    timeout = 300
    source_code_hash = "${base64sha256(file("code/convertoaudio.zip"))}"
    environment {
        variables = {
            DB_TABLE_NAME = "${var.dbtablename}"
            BUCKET_NAME = "${var.audiobucketname}"
        }
    }
}

resource "aws_lambda_function" "getpostslambda" {
    filename         = "getposts.zip"
    runtime = "python2.7"
    function_name = "PostReader_GetPosts"
    role = "${aws_iam_role.LambdaPostReaderRole.arn}"
    handler = "getposts.lambda_handler"
    source_code_hash = "${base64sha256(file("getposts.zip"))}"
    environment {
        variables = {
            DB_TABLE_NAME = "${var.dbtablename}"
        }
    }
}

resource "aws_lambda_permission" "with_sns" {
    statement_id = "AllowExecutionFromSNS"
    action = "lambda:InvokeFunction"
    function_name = "${aws_lambda_function.converttoaudiolambda.arn}"
    principal = "sns.amazonaws.com"
    source_arn = "${aws_sns_topic.newposttopic.arn}"
}