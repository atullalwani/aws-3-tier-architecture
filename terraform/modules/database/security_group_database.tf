resource "aws_security_group" "private_database_out" {
  name = "Private_Database"
  vpc_id = "${var.M_FRONT_VPC_ID}"

  tags {
    Name = "${var.ENVIRONMENT}-Private_Database"
  }
}

resource "aws_security_group_rule" "private_database_out_sqlnet" {
  security_group_id = "${aws_security_group.private_database_out.id}"
  type = "egress"
  from_port = 3306
  to_port = 3306
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.private_database_in.id}"
}

resource "aws_security_group" "private_database_in" {
  name = "Database_Private_In"
  vpc_id = "${var.M_FRONT_VPC_ID}"

  tags {
    Name = "${var.ENVIRONMENT}-Database_Private_In"
  }
}

resource "aws_security_group_rule" "private_database_in_sqlnet" {
  security_group_id = "${aws_security_group.private_database_in.id}"
  type = "ingress"
  from_port = 3306
  to_port = 3306
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.private_database_out.id}"
}

resource "aws_security_group" "public_database_out" {
  name = "Public_Database"
  vpc_id = "${var.M_FRONT_VPC_ID}"

  tags {
    Name = "${var.ENVIRONMENT}-Public_Database"
  }
}

resource "aws_security_group_rule" "public_database_out_sqlnet" {
  security_group_id = "${aws_security_group.public_database_out.id}"
  type = "egress"
  from_port = 3306
  to_port = 3306
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.public_database_in.id}"
}

resource "aws_security_group" "public_database_in" {
  name = "Database_Public_In"
  vpc_id = "${var.M_FRONT_VPC_ID}"

  tags {
    Name = "${var.ENVIRONMENT}-Database_Public_In"
  }
}

resource "aws_security_group_rule" "public_database_in_sqlnet" {
  security_group_id = "${aws_security_group.public_database_in.id}"
  type = "ingress"
  from_port = 3306
  to_port = 3306
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.public_database_out.id}"
}
