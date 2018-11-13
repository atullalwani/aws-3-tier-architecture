# resource "aws_network_acl" "public" {
#   vpc_id = "${aws_vpc.default.id}"
#
#   ingress {
#     protocol   = "tcp"
#     rule_no    = 10
#     action     = "allow"
#     cidr_block = "0.0.0.0/0"
#     from_port  = 80
#     to_port    = 80
#   }
#
#   ingress {
#     protocol   = "tcp"
#     rule_no    = 20
#     action     = "allow"
#     cidr_block = "0.0.0.0/0"
#     from_port  = 443
#     to_port    = 443
#   }
#
#
#   ingress {
#     protocol   = "tcp"
#     rule_no    = 30
#     action     = "allow"
#     cidr_block = "0.0.0.0/0"
#     from_port  = 22
#     to_port    = 22
#   }
#
#   ingress {
#     protocol   = "tcp"
#     rule_no    = 40
#     action     = "allow"
#     cidr_block = "0.0.0.0/0"
#     from_port  = 1024
#     to_port    = 65535
#   }
#
#   egress {
#     protocol   = "tcp"
#     rule_no    = 10
#     action     = "allow"
#     cidr_block = "0.0.0.0/0"
#     from_port  = 80
#     to_port    = 80
#   }
#
#   egress {
#     protocol   = "tcp"
#     rule_no    = 20
#     action     = "allow"
#     cidr_block = "0.0.0.0/0"
#     from_port  = 443
#     to_port    = 443
#   }
#
#   egress {
#     protocol   = "tcp"
#     rule_no    = 30
#     action     = "allow"
#     cidr_block = "0.0.0.0/0"
#     from_port  = 22
#     to_port    = 22
#   }
#
#   egress {
#     protocol   = "tcp"
#     rule_no    = 40
#     action     = "allow"
#     cidr_block = "0.0.0.0/0"
#     from_port  = 1024
#     to_port    = 65535
#   }
#
#
#   egress {
#     protocol   = "tcp"
#     rule_no    = 50
#     action     = "allow"
#     cidr_block = "0.0.0.0/0"
#     from_port  = 3306
#     to_port    = 3306
#   }
#
#   subnet_ids = ["${aws_subnet.public.*.id}"]
#
#   tags {
#     Name = "${var.ENVIRONMENT}-public"
#   }
# }
