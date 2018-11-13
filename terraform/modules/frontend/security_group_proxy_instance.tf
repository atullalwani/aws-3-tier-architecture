resource "aws_security_group" "proxy_instance" {
  name = "Instance_Proxy"
  vpc_id = "${aws_vpc.default.id}"

  # # Creates a cycle with public_elb_outbound security group
  # ingress {
  #   from_port = 443
  #   to_port = 443
  #   protocol = "tcp"
  #   security_groups = ["${aws_security_group.public_elb.id}"]
  # }
  #
  # ingress {
  #   from_port = 80
  #   to_port = 80
  #   protocol = "tcp"
  #   security_groups = ["${aws_security_group.public_elb.id}"]
  # }
  #
  # egress {
  #   from_port = 80
  #   to_port = 80
  #   protocol = "tcp"
  #   # source_security_group_id = "${var.APPLICATION_ELB_INBOUND_ID}"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }
  #
  # egress {
  #   from_port = 443
  #   to_port = 443
  #   protocol = "tcp"
  #   # source_security_group_id = "${var.APPLICATION_ELB_INBOUND_ID}"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }

  tags {
    Name = "${var.ENVIRONMENT}_Instance_Proxy"
  }
}

resource "aws_security_group_rule" "proxy_inbound_http" {
  security_group_id = "${aws_security_group.proxy_instance.id}"
  type = "ingress"
  from_port = 443
  to_port = 443
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.public_elb.id}"
}

resource "aws_security_group_rule" "proxy_inbound_https" {
  security_group_id = "${aws_security_group.proxy_instance.id}"
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.public_elb.id}"
}


resource "aws_security_group_rule" "proxy_http_out" {
  security_group_id = "${aws_security_group.proxy_instance.id}"
  type = "egress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  # source_security_group_id = "${var.APPLICATION_ELB_INBOUND_ID}"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "proxy_https_out" {
  security_group_id = "${aws_security_group.proxy_instance.id}"
  type = "egress"
  from_port = 443
  to_port = 443
  protocol = "tcp"
  # source_security_group_id = "${var.APPLICATION_ELB_INBOUND_ID}"
  cidr_blocks = ["0.0.0.0/0"]
}



# resource "aws_security_group" "proxy_instance_outbound" {
#   name = "Instance_Proxy_Out"
#   vpc_id = "${aws_vpc.default.id}"
#   egress {
#     from_port = 80
#     to_port = 80
#     protocol = "tcp"
#     # source_security_group_id = "${var.APPLICATION_ELB_INBOUND_ID}"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#
#   egress {
#     from_port = 443
#     to_port = 443
#     protocol = "tcp"
#     # source_security_group_id = "${var.APPLICATION_ELB_INBOUND_ID}"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   tags {
#      Name = "${var.ENVIRONMENT}_Instance_Proxy_Out"
#   }
# }
