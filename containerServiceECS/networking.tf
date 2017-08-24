resource "aws_vpc" "container_vpc" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = true

  tags {
    Name = "container-vpc"
  }
}

resource "aws_subnet" "container_subnet" {
  vpc_id            = "${aws_vpc.container_vpc.id}"
  cidr_block        = "${var.subnet_cidr}"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"

  tags {
    Name = "container-subnet"
  }
}

resource "aws_internet_gateway" "container_internet_gateway" {
  vpc_id = "${aws_vpc.container_vpc.id}"

  tags {
    Name = "container-internet-gateway"
  }
}

resource "aws_route_table" "container_external_route_table" {
  vpc_id = "${aws_vpc.container_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.container_internet_gateway.id}"
  }

  tags {
    Name = "container-external-route-table"
  }
}

resource "aws_route_table_association" "container_subnet_route_association" {
  subnet_id      = "${aws_subnet.container_subnet.id}"
  route_table_id = "${aws_route_table.container_external_route_table.id}"
}
