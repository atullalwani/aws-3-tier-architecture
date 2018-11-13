resource "aws_network_acl" "private" {
  vpc_id = "${var.M_FRONT_VPC_ID}"

  ingress {
    protocol   = "tcp"
    rule_no    = 10
    action     = "allow"
    cidr_block = "172.20.0.0/21"
    from_port  = 80
    to_port    = 80
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 20
    action     = "allow"
    cidr_block = "172.20.0.0/21"
    from_port  = 443
    to_port    = 443
  }


  ingress {
    protocol   = "tcp"
    rule_no    = 30
    action     = "allow"
    cidr_block = "172.20.0.0/21"
    from_port  = 22
    to_port    = 22
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 40
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1024
    to_port    = 65535
  }

  egress {
    protocol   = "tcp"
    rule_no    = 10
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }

  egress {
    protocol   = "tcp"
    rule_no    = 20
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 443
    to_port    = 443
  }

  egress {
    protocol   = "tcp"
    rule_no    = 30
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 22
    to_port    = 22
  }

  egress {
    protocol   = "tcp"
    rule_no    = 40
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1024
    to_port    = 65535
  }

  egress {
    protocol   = "tcp"
    rule_no    = 50
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 3306
    to_port    = 3306
  }

  subnet_ids = ["${aws_subnet.private.*.id}"]

  tags {
    Name = "${var.ENVIRONMENT}-private"
  }
}
