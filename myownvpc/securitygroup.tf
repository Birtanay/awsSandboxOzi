resource "aws_security_group_rule" "ssh1" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.MyWebDMZ.id}"
}


resource "aws_security_group_rule" "http1" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.MyWebDMZ.id}"
}

resource "aws_security_group_rule" "https1" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.MyWebDMZ.id}"
}

resource "aws_security_group_rule" "allow_all1" {
  type              = "egress"
  to_port           = 0
  protocol          = "-1"
  from_port         = 0
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.MyWebDMZ.id}"
}

resource "aws_security_group" "MyWebDMZ" {
  name        = "MyWebDMZ"
  description = "MyWebDMZ"

  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "MyWebDMZ"
  }
}

resource "aws_security_group_rule" "ssh2" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.MySQLServerSG.id}"
}


resource "aws_security_group_rule" "mysql2" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  cidr_blocks       = ["${lookup(var.cidrs,"public_subnet")}"]
  security_group_id = "${aws_security_group.MySQLServerSG.id}"
}

resource "aws_security_group_rule" "icmp2" {
  type              = "ingress"
  from_port         = 8
  to_port           = 0
  protocol          = "icmp"
  cidr_blocks       = ["${lookup(var.cidrs,"public_subnet")}"]
  security_group_id = "${aws_security_group.MySQLServerSG.id}"
}

resource "aws_security_group_rule" "allow_all2" {
  type              = "egress"
  to_port           = 0
  protocol          = "-1"
  from_port         = 0
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.MySQLServerSG.id}"
}

resource "aws_security_group" "MySQLServerSG" {
  name        = "MySQLServerSG"
  description = "MySQLServerSG"

  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "MySQLServerSG"
  }
}
