resource "aws_security_group" "Tutorial_01_asg" {
  name = "AWSTutorial01"
  vpc_id = "${aws_vpc.my_vpc.id}"
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