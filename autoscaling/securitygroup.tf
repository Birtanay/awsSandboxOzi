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
  ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      security_groups = ["${aws_security_group.elb_securitygroup.id}"]
  }  
  tags {
  "Name" = "AWS_Tutorial_01_asg"
  }
}

resource "aws_security_group" "elb_securitygroup" {
  vpc_id = "${aws_vpc.my_vpc.id}"
  name = "elb"
  description = "security group for load balancer"
  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  } 
  tags {
    Name = "elb"
  }
}