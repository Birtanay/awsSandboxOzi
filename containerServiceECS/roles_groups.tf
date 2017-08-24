resource "aws_security_group_rule" "22_22_ingress" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.ssh_http_from_to_anywhere.id}"
}

resource "aws_security_group_rule" "22_22_egress" {
  type              = "egress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.ssh_http_from_to_anywhere.id}"
}

resource "aws_security_group_rule" "80_80_ingress" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.ssh_http_from_to_anywhere.id}"
}

resource "aws_security_group_rule" "80_80_egress" {
  type              = "egress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.ssh_http_from_to_anywhere.id}"
}

resource "aws_security_group" "ssh_http_from_to_anywhere" {
  name        = "ssh_and_http_from_and_to_anywhere"
  description = "Allow all traffic in and out"

  #vpc_id      = "${aws_vpc.container_vpc.id}"
  lifecycle {
    create_before_destroy = true
  }

  tags {
    Name = "ssh-and-http-from-and-to-anywhere"
  }
}

data "aws_iam_policy_document" "instance_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecs_instance_role" {
  name               = "ecs-instance-role"
  assume_role_policy = "${data.aws_iam_policy_document.instance_assume_role_policy.json}"
}

resource "aws_iam_role_policy" "ecs_instance_role_policy" {
  name   = "ecs-instance-role-policy"
  policy = "${file("AmazonEC2ContainerServiceforEC2Role.json")}"
  role   = "${aws_iam_role.ecs_instance_role.id}"
}

resource "aws_iam_role" "ecs_service_role" {
  name               = "ecs-service-role"
  assume_role_policy = "${data.aws_iam_policy_document.instance_assume_role_policy.json}"
}

resource "aws_iam_role_policy" "ecs_service_role_policy" {
  name   = "ecs-service-role-policy"
  policy = "${file("AmazonEC2ContainerServiceRole.json")}"
  role   = "${aws_iam_role.ecs_service_role.id}"
}

resource "aws_iam_instance_profile" "ecs" {
  name = "ecs-instance-profile"
  role = "${aws_iam_role.ecs_instance_role.name}"
}
