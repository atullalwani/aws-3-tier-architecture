resource "aws_subnet" "public" {
  count = "${length(var.PUBLIC_SUBNET_CIDR)}"
  vpc_id = "${aws_vpc.default.id}"
  cidr_block = "${var.PUBLIC_SUBNET_CIDR[count.index]}"
  availability_zone = "${var.AWS_REGION}${var.AVAILABILITY_ZONE[count.index % 2]}"
  map_public_ip_on_launch = true
  tags {
    Name = "${var.ENVIRONMENT}-public_subnet_${var.AVAILABILITY_ZONE[count.index % 2]}_${count.index}"
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = "${aws_vpc.default.id}"

  tags {
    Name = "${var.ENVIRONMENT}-Internet_Gateway"
  }
}

resource "aws_route_table" "route_table_public" {
  vpc_id = "${aws_vpc.default.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.internet_gateway.id}"
  }

  tags {
    Name = "${var.ENVIRONMENT}-Public_Route_Table"
  }
}

resource "aws_route_table_association" "subnet_public" {
  count = "${length(var.PUBLIC_SUBNET_CIDR)}"
  subnet_id = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id = "${aws_route_table.route_table_public.id}"
}

resource "aws_eip" "nat_gateway_elastic_ip" {
  count = "${length(var.PRIVATE_SUBNET_CIDR)}"
  vpc = true
}

resource "aws_nat_gateway" "nat_gateway" {
    count = "${length(var.PRIVATE_SUBNET_CIDR)}"
    allocation_id = "${element(aws_eip.nat_gateway_elastic_ip.*.id, count.index)}"
    subnet_id = "${element(aws_subnet.public.*.id, count.index)}"
}
