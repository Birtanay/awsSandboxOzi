resource "aws_vpc" "main" {
  cidr_block = "${lookup(var.cidrs,"vpc")}"
  tags {
      Name = "myownvpc"
  }
}


resource "aws_subnet" "public_subnet" {
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${lookup(var.cidrs,"public_subnet")}"
  map_public_ip_on_launch = true
  availability_zone = "${data.aws_availability_zones.available.names[0]}"

  tags {
    Name = "myownpublicsubnet"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${lookup(var.cidrs,"private_subnet")}"
  availability_zone = "${data.aws_availability_zones.available.names[1]}"

  tags {
    Name = "myownprivatesubnet"
  }
}

resource "aws_route_table" "route_table" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "${lookup(var.cidrs,"all")}"
    gateway_id = "${aws_internet_gateway.internet_gateway.id}"
  }

  tags {
    Name = "RouteTableForIGW"
  }
}

resource "aws_route_table_association" "route_table_association" {
  subnet_id      = "${aws_subnet.public_subnet.id}"
  route_table_id = "${aws_route_table.route_table.id}"
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "myowninternetgateway"
  }
}

resource "aws_eip" "eip" {
  vpc = true
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = "${aws_eip.eip.id}"
  subnet_id     = "${aws_subnet.public_subnet.id}"

  tags {
    Name = "myownnatgateway"
  }
}

resource "aws_route_table" "private_route_table" {
    vpc_id = "${aws_vpc.main.id}"
 
    tags {
        Name = "Private route table"
    }
}
 
resource "aws_route" "private_route" {
	route_table_id  = "${aws_route_table.private_route_table.id}"
	destination_cidr_block = "${lookup(var.cidrs,"all")}"
	nat_gateway_id = "${aws_nat_gateway.nat_gateway.id}"
}

resource "aws_route_table_association" "private_route_table_assoc" {
    subnet_id = "${aws_subnet.private_subnet.id}"
    route_table_id = "${aws_route_table.private_route_table.id}"
}