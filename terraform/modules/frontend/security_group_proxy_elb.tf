resource "aws_security_group" "public_elb" {
  name = "ELB_Public"
  vpc_id = "${aws_vpc.default.id}"
  #
  # ingress {
  #   from_port = 443
  #   to_port = 443
  #   protocol = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }
  #
  # ingress {
  #   from_port = 80
  #   to_port = 80
  #   protocol = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }
  #
  # # Creates a cycle with proxy_instance_inbound security group
  # egress {
  #   from_port = 80
  #   to_port = 80
  #   protocol = "tcp"
  #   security_groups = ["${aws_security_group.proxy_instance.id}"]
  # }
  #
  # egress {
  #   from_port = 443
  #   to_port = 443
  #   protocol = "tcp"
  #   security_groups = ["${aws_security_group.proxy_instance.id}"]
  # }
  #
  tags {
    Name = "${var.ENVIRONMENT}_ELB_Public"
  }
}

resource "aws_security_group_rule" "public_elb_inbound_http" {
  security_group_id = "${aws_security_group.public_elb.id}"
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "public_elb_inbound_https" {
  security_group_id = "${aws_security_group.public_elb.id}"
  type = "ingress"
  from_port = 443
  to_port = 443
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "public_elb_outbound_http" {
  security_group_id = "${aws_security_group.public_elb.id}"
  type = "egress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.proxy_instance.id}"
}

resource "aws_security_group_rule" "public_elb_outbound_https" {
  security_group_id = "${aws_security_group.public_elb.id}"
  type = "egress"
  from_port = 443
  to_port = 443
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.proxy_instance.id}"
}



# resource "aws_security_group" "public_elb_outbound" {
#   name = "ELB_Public_Outbound"
#   vpc_id = "${aws_vpc.default.id}"
#
#   ## Creates a cycle with proxy_instance_inbound security group
#   # egress {
#   #   from_port = 80
#   #   to_port = 80
#   #   protocol = "tcp"
#   #   security_groups = ["${aws_security_group.proxy_inbound.id}"]
#   # }
#
#   # egress {
#   #   from_port = 443
#   #   to_port = 443
#   #   protocol = "tcp"
#   #   security_groups = ["${aws_security_group.proxy_inbound.id}"]
#   # }
#   tags {
#     Name = "${var.ENVIRONMENT}_ELB_Public_Outbound"
#
#   }
# }
#
#
# resource "aws_security_group_rule" "public_elb_outbound_http" {
#   security_group_id = "${aws_security_group.public_elb_outbound.id}"
#   type = "egress"
#   from_port = 80
#   to_port = 80
#   protocol = "tcp"
#   source_security_group_id = "${aws_security_group.proxy_instance_inbound.id}"
# }
#
# resource "aws_security_group_rule" "public_elb_outbound_https" {
#   security_group_id = "${aws_security_group.public_elb_outbound.id}"
#   type = "egress"
#   from_port = 443
#   to_port = 443
#   protocol = "tcp"
#   source_security_group_id = "${aws_security_group.proxy_instance_inbound.id}"
# }
#

# resource "aws_security_group" "public_elb_inbound" {
# #   name = "ELB_Public_Inbound"
# #   vpc_id = "${aws_vpc.default.id}"
# #
# #   ingress {
# #     from_port = 443
# #     to_port = 443
# #     protocol = "tcp"
# #     cidr_blocks = ["0.0.0.0/0"]
# #   }
# #
# #   ingress {
# #     from_port = 80
# #     to_port = 80
# #     protocol = "tcp"
# #     cidr_blocks = ["0.0.0.0/0"]
# #   }
# #   tags {
# #     Name = "${var.ENVIRONMENT}_ELB_Public_Inbound"
# #   }
# # }
# #
# #
# # resource "aws_security_group" "public_elb_outbound" {
# #   name = "ELB_Public_Outbound"
# #   vpc_id = "${aws_vpc.default.id}"
# #
# #   ## Creates a cycle with proxy_instance_inbound security group
# #   # egress {
# #   #   from_port = 80
# #   #   to_port = 80
# #   #   protocol = "tcp"
# #   #   security_groups = ["${aws_security_group.proxy_inbound.id}"]
# #   # }
# #
# #   # egress {
# #   #   from_port = 443
# #   #   to_port = 443
# #   #   protocol = "tcp"
# #   #   security_groups = ["${aws_security_group.proxy_inbound.id}"]
# #   # }
# #   tags {
# #     Name = "${var.ENVIRONMENT}_ELB_Public_Outbound"
# #
# #   }
# # }
# #
# #
# # resource "aws_security_group_rule" "public_elb_outbound_http" {
# #   security_group_id = "${aws_security_group.public_elb_outbound.id}"
# #   type = "egress"
# #   from_port = 80
# #   to_port = 80
# #   protocol = "tcp"
# #   source_security_group_id = "${aws_security_group.proxy_instance_inbound.id}"
# # }
# #
# # resource "aws_security_group_rule" "public_elb_outbound_https" {
# #   security_group_id = "${aws_security_group.public_elb_outbound.id}"
# #   type = "egress"
# #   from_port = 443
# #   to_port = 443
# #   protocol = "tcp"
# #   source_security_group_id = "${aws_security_group.proxy_instance_inbound.id}"
# # }

# resource "aws_security_group_rule" "public_elb_https_in" {
#   security_group_id = "${aws_security_group.public_elb_inbound.id}"
#   type = "ingress"
#   from_port = 443
#   to_port = 443
#   protocol = "tcp"
#   cidr_blocks = ["0.0.0.0/0"]
# }

# resource "aws_security_group_rule" "public_elb_http_in" {
#   security_group_id = "${aws_security_group.public_elb_inbound.id}"
#   type = "ingress"
#   from_port = 80
#   to_port = 80
#   protocol = "tcp"
#   cidr_blocks = ["0.0.0.0/0"]
# }
