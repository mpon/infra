resource "aws_vpc" "vpc" {
  cidr_block           = "${var.cidr_block["vpc"]}"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags {
    Name = "${var.name}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name = "${var.name}"
  }
}

resource "aws_subnet" "public_a" {
  vpc_id            = "${aws_vpc.vpc.id}"
  availability_zone = "ap-northeast-1a"
  cidr_block        = "${var.cidr_block["public_a"]}"

  tags {
    Name = "${var.name}-public-a"
  }
}

resource "aws_subnet" "public_c" {
  vpc_id            = "${aws_vpc.vpc.id}"
  availability_zone = "ap-northeast-1c"
  cidr_block        = "${var.cidr_block["public_c"]}"

  tags {
    Name = "${var.name}-public-c"
  }
}

resource "aws_subnet" "private_a" {
  vpc_id            = "${aws_vpc.vpc.id}"
  availability_zone = "ap-northeast-1a"
  cidr_block        = "${var.cidr_block["private_a"]}"

  tags {
    Name = "${var.name}-private-a"
  }
}

resource "aws_subnet" "private_c" {
  vpc_id            = "${aws_vpc.vpc.id}"
  availability_zone = "ap-northeast-1c"
  cidr_block        = "${var.cidr_block["private_c"]}"

  tags {
    Name = "${var.name}-private-c"
  }
}

resource "aws_eip" "nat" {
  vpc = true

  tags {
    Name = "${var.name}-nat"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = "${aws_eip.nat.id}"
  subnet_id     = "${aws_subnet.public_a.id}"

  tags {
    Name = "${var.name}-nat"
  }
}

resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }
}

resource "aws_route_table" "private" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.nat.id}"
  }
}

resource "aws_route_table_association" "public_a" {
  subnet_id      = "${aws_subnet.public_a.id}"
  route_table_id = "${aws_route_table.public.id}"
}

resource "aws_route_table_association" "public_c" {
  subnet_id      = "${aws_subnet.public_c.id}"
  route_table_id = "${aws_route_table.public.id}"
}

resource "aws_route_table_association" "private_a" {
  subnet_id      = "${aws_subnet.private_a.id}"
  route_table_id = "${aws_route_table.private.id}"
}

resource "aws_route_table_association" "private_c" {
  subnet_id      = "${aws_subnet.private_c.id}"
  route_table_id = "${aws_route_table.private.id}"
}
