resource "aws_network_acl" "database" {
  vpc_id = "${var.M_FRONT_VPC_ID}"

  ingress {
    protocol   = "tcp"
    rule_no    = 10
    action     = "allow"
    cidr_block = "172.20.0.0/21"
    from_port  = 3306
    to_port    = 3306
  }

  egress {
    protocol   = "tcp"
    rule_no    = 20
    action     = "allow"
    cidr_block = "172.20.0.0/21"
    from_port  = 1024
    to_port    = 65535
  }

  subnet_ids = ["${aws_subnet.database.*.id}"]

  tags {
    Name = "${var.ENVIRONMENT}-database"
  }
}
