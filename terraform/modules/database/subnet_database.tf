resource "aws_subnet" "database" {
  count = 2
  vpc_id = "${var.M_FRONT_VPC_ID}"
  cidr_block = "${var.DATABASE_SUBNET_CIDR[count.index]}"
  availability_zone = "${var.AWS_REGION}${var.AVAILABILITY_ZONE[count.index]}"

  tags {
    Name = "${var.ENVIRONMENT}-database_subnet_${var.AVAILABILITY_ZONE[count.index]}_${count.index}"
  }
}

resource "aws_route_table" "route_table_database" {
  vpc_id = "${var.M_FRONT_VPC_ID}"

  tags {
    Name = "${var.ENVIRONMENT}-Route_Table_Database"
  }
}

resource "aws_route_table_association" "database" {
  count = "${length(var.DATABASE_SUBNET_CIDR)}"
  subnet_id = "${element(aws_subnet.database.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.route_table_database.*.id, count.index)}"
}

resource "aws_db_subnet_group" "rds_subnets" {
    name = "rds_subnets_group"
    description = "RDS subnets"
    subnet_ids = ["${aws_subnet.database.*.id}"]

    tags {
        Name = "${var.ENVIRONMENT}-RDS_Subnets"
    }
}
