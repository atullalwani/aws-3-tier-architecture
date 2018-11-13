resource "aws_subnet" "private" {
  count = "${length(var.PRIVATE_SUBNET_CIDR)}"
  vpc_id = "${var.M_FRONT_VPC_ID}"
  cidr_block = "${var.PRIVATE_SUBNET_CIDR[count.index]}"
  availability_zone = "${var.AWS_REGION}${var.AVAILABILITY_ZONE[count.index % 2]}"
  map_public_ip_on_launch = true
  tags {
    Name = "${var.ENVIRONMENT}-private_subnet_${var.AVAILABILITY_ZONE[count.index % 2]}_${count.index}"
  }
}

resource "aws_route_table" "route_table_private" {
  count = "${length(var.PRIVATE_SUBNET_CIDR)}"
  vpc_id = "${var.M_FRONT_VPC_ID}"
  tags {
    Name = "${var.ENVIRONMENT}-Private_Route_Table_${count.index}"
  }
}

resource "aws_route" "route_private" {
  count = "${length(var.PRIVATE_SUBNET_CIDR)}"
  route_table_id = "${element(aws_route_table.route_table_private.*.id, count.index)}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = "${element(var.M_FRONT_NAT_GATEWAY_ID, count.index)}"
}

resource "aws_route_table_association" "subnet_application_a" {
  count = "${length(var.PRIVATE_SUBNET_CIDR)}"
  subnet_id = "${element(aws_subnet.private.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.route_table_private.*.id, count.index)}"
}
