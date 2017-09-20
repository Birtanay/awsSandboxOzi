resource "aws_security_group" "mysecuritygroup" {
  name = "AWSTutorial01"
  vpc_id = "${module.vpc.vpc_id}"
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
  "Name" = "AWS_Tutorial_01_asg"
  }
}