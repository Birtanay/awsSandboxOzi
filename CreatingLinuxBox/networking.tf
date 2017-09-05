resource "aws_vpc" "my_vpc" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = true

  tags {
    Name = "my-vpc"
  }
}

resource "aws_subnet" "my_public_subnet" {
  vpc_id            = "${aws_vpc.my_vpc.id}"
  cidr_block        = "${var.subnet_cidr}"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"
  map_public_ip_on_launch = "true"
  tags {
    Name = "my-subnet"
  }
}

resource "aws_internet_gateway" "my_internet_gateway" {
  vpc_id = "${aws_vpc.my_vpc.id}"

  tags {
    Name = "my-internet-gateway"
  }
}
resource "aws_route_table" "my_external_route_table" {
  vpc_id = "${aws_vpc.my_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.my_internet_gateway.id}"
  }

  tags {
    Name = "my-external-route-table"
  }
}
resource "aws_route_table_association" "container_subnet_route_association" {
  subnet_id      = "${aws_subnet.my_public_subnet.id}"
  route_table_id = "${aws_route_table.my_external_route_table.id}"
}

