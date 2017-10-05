resource "aws_flow_log" "test_flow_log" {
  log_group_name = "${aws_cloudwatch_log_group.flowloggroup.name}"
  iam_role_arn   = "${aws_iam_role.flowlogrole.arn}"
  vpc_id         = "${aws_vpc.main.id}"
  traffic_type   = "ALL"
}

resource "aws_cloudwatch_log_group" "flowloggroup" {
  name = "myvpcflowloggroup"
}