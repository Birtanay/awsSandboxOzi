resource "aws_security_group" "app_security_group" {
  vpc_id = "${aws_vpc.vpc_ozi.id}"
  name = "app-prod-security-group"
  description = "security group for my app"
  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  } 


  tags {
    Name = "app-prod-security-group"
  }
}
resource "aws_security_group" "mariadb_security_group" {
  vpc_id = "${aws_vpc.vpc_ozi.id}"
  name = "mariadb-security-group"
  description = "mariadb-security-group"
  ingress {
      from_port = 3306
      to_port = 3306
      protocol = "tcp"
      security_groups = ["${aws_security_group.app_security_group.id}"]              
  }
  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
      self = true
  }
  tags {
    Name = "mariadb-security-group"
  }
}