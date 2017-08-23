resource "aws_vpc" "vpc_ozi" {
  enable_dns_hostnames = true
  cidr_block           = "${var.vpc_cidr}"

  tags {
    Name = "vpc-ozi"
  }
}

resource "aws_internet_gateway" "internet_gateway_ozi" {
  vpc_id = "${aws_vpc.vpc_ozi.id}"

  tags {
    Name = "igw-ozi"
  }
}

resource "aws_eip" "eip_zone1" {
  vpc = true
}

resource "aws_eip" "eip_zone2" {
  vpc = true
}

resource "aws_subnet" "public_subnet_zone1" {
  vpc_id            = "${aws_vpc.vpc_ozi.id}"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"
  cidr_block        = "${var.public_subnet_zone1_cidr}"

  tags {
    Name = "public-subnet-zone-1"
  }
}

resource "aws_subnet" "public_subnet_zone2" {
  vpc_id            = "${aws_vpc.vpc_ozi.id}"
  availability_zone = "${data.aws_availability_zones.available.names[1]}"
  cidr_block        = "${var.public_subnet_zone2_cidr}"

  tags {
    Name = "public-subnet-zone-2"
  }
}

resource "aws_subnet" "private_subnet_zone1" {
  vpc_id            = "${aws_vpc.vpc_ozi.id}"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"
  cidr_block        = "${var.private_subnet_zone1_cidr}"

  tags {
    Name = "private-subnet-zone-1"
  }
}

resource "aws_subnet" "private_subnet_zone2" {
  vpc_id            = "${aws_vpc.vpc_ozi.id}"
  availability_zone = "${data.aws_availability_zones.available.names[1]}"
  cidr_block        = "${var.private_subnet_zone2_cidr}"

  tags {
    Name = "private-subnet-zone-2"
  }
}

resource "aws_db_subnet_group" "rds_db_subnet" {
  name       = "subnet_group"
  subnet_ids = ["${aws_subnet.private_subnet_zone1.id}", "${aws_subnet.private_subnet_zone2.id}"]
}

resource "aws_nat_gateway" "nat_gateway_zone1" {
  allocation_id = "${aws_eip.eip_zone1.id}"
  subnet_id     = "${aws_subnet.public_subnet_zone1.id}"
  depends_on    = ["aws_internet_gateway.internet_gateway_ozi"]
}

resource "aws_nat_gateway" "nat_gateway_zone2" {
  allocation_id = "${aws_eip.eip_zone2.id}"
  subnet_id     = "${aws_subnet.public_subnet_zone2.id}"
  depends_on    = ["aws_internet_gateway.internet_gateway_ozi"]
}

resource "aws_route_table" "public_route_table" {
  vpc_id = "${aws_vpc.vpc_ozi.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.internet_gateway_ozi.id}"
  }

  tags {
    Name = "public-route-table-ozi"
  }
}

resource "aws_route_table" "private_route_table_zone1" {
  vpc_id = "${aws_vpc.vpc_ozi.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_nat_gateway.nat_gateway_zone1.id}"
  }

  tags {
    Name = "priivate-route-table-zone1-ozi"
  }
}

resource "aws_route_table" "private_route_table_zone2" {
  vpc_id = "${aws_vpc.vpc_ozi.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_nat_gateway.nat_gateway_zone2.id}"
  }

  tags {
    Name = "priivate-route-table-zone2-ozi"
  }
}

resource "aws_route_table_association" "route_table_assoc_public_zone1" {
  subnet_id      = "${aws_subnet.public_subnet_zone1.id}"
  route_table_id = "${aws_route_table.public_route_table.id}"
}

resource "aws_route_table_association" "route_table_assoc_public_zone2" {
  subnet_id      = "${aws_subnet.public_subnet_zone2.id}"
  route_table_id = "${aws_route_table.public_route_table.id}"
}

resource "aws_route_table_association" "route_table_assoc_private_zone1" {
  subnet_id      = "${aws_subnet.private_subnet_zone1.id}"
  route_table_id = "${aws_route_table.private_route_table_zone1.id}"
}

resource "aws_route_table_association" "route_table_assoc_private_zone2" {
  subnet_id      = "${aws_subnet.private_subnet_zone2.id}"
  route_table_id = "${aws_route_table.private_route_table_zone2.id}"
}

resource "aws_route53_zone" "wordpress_ael" {
  name   = "wordpress.ael."
  vpc_id = "${aws_vpc.vpc_ozi.id}"
}

resource "aws_route53_record" "db_wordpress_ael" {
  zone_id = "${aws_route53_zone.wordpress_ael.zone_id}"
  name    = "${var.db_fqdn}"
  type    = "CNAME"
  ttl     = "300"

  records = [
    "${aws_db_instance.rds_db_instance.address}",
  ]
}

# zoneA and zoneB should have same dns name (?)
resource "aws_route53_record" "nfs_wordpress_ael" {
  zone_id = "${aws_route53_zone.wordpress_ael.zone_id}"
  name    = "${var.nfs_fqdn}"
  type    = "CNAME"
  ttl     = "300"

  records = [
    "${aws_efs_mount_target.efs_private_zone1.dns_name}",
  ]
}

variable "db_fqdn" {
  default = "db.wordpress.ael"
}

variable "nfs_fqdn" {
  default = "nfs.wordpress.ael"
}
