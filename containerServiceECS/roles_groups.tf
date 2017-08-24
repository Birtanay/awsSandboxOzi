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

  vpc_id = "${aws_vpc.container_vpc.id}"

  tags {
    Name = "ssh-and-http-from-and-to-anywhere"
  }
}

resource "aws_iam_role" "ecs_instance_role" {
  name               = "ecs-instance-role"
  assume_role_policy = "${file("ec2-role.json")}"
}

resource "aws_iam_role_policy_attachment" "ecs_instance_role_policy" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
  role       = "${aws_iam_role.ecs_instance_role.id}"
}

resource "aws_iam_instance_profile" "ecs" {
  name = "ecs-instance-profile"
  path = "/"
  role = "${aws_iam_role.ecs_instance_role.name}"
}

resource "aws_iam_role" "ecs_elb" {
  name               = "ecs-elb"
  assume_role_policy = "${file("ecs-role.json")}"
}

resource "aws_iam_role_policy_attachment" "ecs_elb" {
  role       = "${aws_iam_role.ecs_elb.id}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
}
