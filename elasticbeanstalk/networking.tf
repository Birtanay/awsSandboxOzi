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

resource "aws_nat_gateway" "nat_gateway_zone" {
  allocation_id = "${aws_eip.eip_zone.id}"
  subnet_id     = "${aws_subnet.public_subnet_zone1.id}"
  depends_on    = ["aws_internet_gateway.internet_gateway_ozi"]
}

resource "aws_eip" "eip_zone" {
  vpc = true
}


resource "aws_subnet" "public_subnet_zone1" {
  vpc_id            = "${aws_vpc.vpc_ozi.id}"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"
  cidr_block        = "${var.public_subnet_zone1_cidr}"
  map_public_ip_on_launch="true"
  tags {
    Name = "public-subnet-zone-1"
  }
}

resource "aws_subnet" "public_subnet_zone2" {
  vpc_id            = "${aws_vpc.vpc_ozi.id}"
  availability_zone = "${data.aws_availability_zones.available.names[1]}"
  cidr_block        = "${var.public_subnet_zone2_cidr}"
  map_public_ip_on_launch="true"

  tags {
    Name = "public-subnet-zone-2"
  }
}

resource "aws_subnet" "private_subnet_zone1" {
  vpc_id            = "${aws_vpc.vpc_ozi.id}"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"
  cidr_block        = "${var.private_subnet_zone1_cidr}"
  map_public_ip_on_launch="false"

  tags {
    Name = "private-subnet-zone-1"
  }
}

resource "aws_subnet" "private_subnet_zone2" {
  vpc_id            = "${aws_vpc.vpc_ozi.id}"
  availability_zone = "${data.aws_availability_zones.available.names[1]}"
  cidr_block        = "${var.private_subnet_zone2_cidr}"
  map_public_ip_on_launch="false"

  tags {
    Name = "private-subnet-zone-2"
  }
}

resource "aws_db_subnet_group" "rds_db_subnet" {
  name       = "subnet_group"
  description = "RDS subnet group"
  subnet_ids = ["${aws_subnet.private_subnet_zone1.id}", "${aws_subnet.private_subnet_zone2.id}"]
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

resource "aws_route_table" "private_route_table" {
  vpc_id = "${aws_vpc.vpc_ozi.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_nat_gateway.nat_gateway_zone.id}"
  }

  tags {
    Name = "priivate-route-table-zone1-ozi"
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
  route_table_id = "${aws_route_table.private_route_table.id}"
}

resource "aws_route_table_association" "route_table_assoc_private_zone2" {
  subnet_id      = "${aws_subnet.private_subnet_zone2.id}"
  route_table_id = "${aws_route_table.private_route_table.id}"
}

