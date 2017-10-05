resource "aws_network_acl" "mynacl" {
  vpc_id = "${aws_vpc.main.id}"
  subnet_ids = ["${aws_subnet.public_subnet.id}"]
  tags {
      Name = "mynacl"
  }
}

resource "aws_network_acl_rule" "mynacl_rule_100_ingress" {
  network_acl_id = "${aws_network_acl.mynacl.id}"
  rule_number    = 100
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 80
  to_port        = 80
}

resource "aws_network_acl_rule" "mynacl_rule_100_egress" {
  network_acl_id = "${aws_network_acl.mynacl.id}"
  rule_number    = 100
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 80
  to_port        = 80
}

resource "aws_network_acl_rule" "mynacl_rule_200_ingress" {
  network_acl_id = "${aws_network_acl.mynacl.id}"
  rule_number    = 200
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 443
  to_port        = 443
}

resource "aws_network_acl_rule" "mynacl_rule_200_egress" {
  network_acl_id = "${aws_network_acl.mynacl.id}"
  rule_number    = 200
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 443
  to_port        = 443
}

resource "aws_network_acl_rule" "mynacl_rule_300_ingress" {
  network_acl_id = "${aws_network_acl.mynacl.id}"
  rule_number    = 300
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 22
  to_port        = 22
}

resource "aws_network_acl_rule" "mynacl_rule_300_egress" {
  network_acl_id = "${aws_network_acl.mynacl.id}"
  rule_number    = 300
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 22
  to_port        = 22
}

resource "aws_network_acl_rule" "mynacl_rule_400_ingress" {
  network_acl_id = "${aws_network_acl.mynacl.id}"
  rule_number    = 400
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 3389
  to_port        = 3389
}

resource "aws_network_acl_rule" "mynacl_rule_400_egress" {
  network_acl_id = "${aws_network_acl.mynacl.id}"
  rule_number    = 400
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 3389
  to_port        = 3389
}

resource "aws_network_acl_rule" "mynacl_rule_ephemeral_ingress" {
  network_acl_id = "${aws_network_acl.mynacl.id}"
  rule_number    = 500
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 1024
  to_port        = 65535
}

resource "aws_network_acl_rule" "mynacl_rule_ephemeral_egress" {
  network_acl_id = "${aws_network_acl.mynacl.id}"
  rule_number    = 500
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 1024
  to_port        = 65535
}