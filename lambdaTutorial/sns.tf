resource "aws_sns_topic" "newposttopic" {
  name = "new_post"
}

resource "aws_sns_topic_subscription" "triggertoconvertlambda" {
  topic_arn = "${aws_sns_topic.newposttopic.arn}"
  protocol  = "lambda"
  endpoint  = "${aws_lambda_function.converttoaudiolambda.arn}"
}