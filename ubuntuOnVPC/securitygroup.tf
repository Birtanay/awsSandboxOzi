resource "aws_security_group_rule" "22_22_ingress" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.ubuntu_ASG.id}"
}

resource "aws_security_group" "ubuntu_ASG" {
  name = "ssh-all-allow"
  vpc_id = "${aws_vpc.my_vpc.id}"
  
  tags {
    "Name" = "AWS_Tutorial_01_asg"
  }
}