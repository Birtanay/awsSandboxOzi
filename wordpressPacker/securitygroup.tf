
resource "aws_security_group_rule" "80_80_ingress" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.ecs_security_group_ingress.id}"
}

resource "aws_security_group_rule" "80_80_egress" {
  type              = "egress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.ec2_security_group_egress.id}"
}

resource "aws_security_group_rule" "80_80_egress_elb" {
  type              = "egress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["${aws_subnet.private_subnet_zone1.cidr_block}", "${aws_subnet.private_subnet_zone2.cidr_block}"]
  security_group_id = "${aws_security_group.elb_security_group_egress.id}"
}

resource "aws_security_group_rule" "443_443_egress" {
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.ec2_security_group_egress.id}"
}

resource "aws_security_group_rule" "2049_2049_egress" {
  type              = "egress"
  from_port         = 2049
  to_port           = 2049
  protocol          = "tcp"
  cidr_blocks       = ["${aws_subnet.private_subnet_zone1.cidr_block}", "${aws_subnet.private_subnet_zone2.cidr_block}"]
  security_group_id = "${aws_security_group.ec2_security_group_egress.id}"
}

resource "aws_security_group_rule" "2049_2049_ingress_nfs" {
  type              = "ingress"
  from_port         = 2049
  to_port           = 2049
  protocol          = "tcp"
  cidr_blocks       = ["${aws_subnet.private_subnet_zone1.cidr_block}", "${aws_subnet.private_subnet_zone2.cidr_block}"]
  security_group_id = "${aws_security_group.efs_security_group_ingress.id}"
}

resource "aws_security_group_rule" "3306_3306_egress" {
  type              = "egress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  cidr_blocks       = ["${aws_subnet.private_subnet_zone1.cidr_block}", "${aws_subnet.private_subnet_zone2.cidr_block}"]
  security_group_id = "${aws_security_group.ec2_security_group_egress.id}"
}

resource "aws_security_group_rule" "3306_3306_ingress_rds" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  cidr_blocks       = ["${aws_subnet.private_subnet_zone1.cidr_block}", "${aws_subnet.private_subnet_zone2.cidr_block}"]
  security_group_id = "${aws_security_group.rds_security_group_ingress.id}"
}

resource "aws_security_group" "ecs_security_group_ingress" {
  name   = "http"
  vpc_id = "${aws_vpc.vpc_ozi.id}"

  tags {
    Name = "ecs-income-http"
  }
}

resource "aws_security_group" "ec2_security_group_egress" {
  name   = "ec2_egress"
  vpc_id = "${aws_vpc.vpc_ozi.id}"

  tags {
    Name = "ec2-outgoing"
  }
}

resource "aws_security_group" "elb_security_group_egress" {
  name   = "http-egress"
  vpc_id = "${aws_vpc.vpc_ozi.id}"

  tags {
    Name = "elb-outgoing"
  }
}

resource "aws_security_group" "rds_security_group_ingress" {
  name   = "mysql"
  vpc_id = "${aws_vpc.vpc_ozi.id}"

  tags {
    Name = "mysql-incoming"
  }
}

resource "aws_security_group" "efs_security_group_ingress" {
  name   = "nfs"
  vpc_id = "${aws_vpc.vpc_ozi.id}"

  tags {
    Name = "nfs-incoming"
  }
}
