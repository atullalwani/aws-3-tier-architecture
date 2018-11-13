resource "aws_security_group" "application_inbound" {
  name = "Application_Instance_Inbound"
  vpc_id = "${var.M_FRONT_VPC_ID}"

  tags {
    Name = "${var.ENVIRONMENT}-Application_Instance_Inbound"
  }
}

resource "aws_security_group_rule" "application_inbound_http" {
  security_group_id = "${aws_security_group.application_inbound.id}"
  type = "ingress"
  from_port = 443
  to_port = 443
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.application_elb_outbound.id}"
}

resource "aws_security_group_rule" "application_inbound_https" {
  security_group_id = "${aws_security_group.application_inbound.id}"
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.application_elb_outbound.id}"
}


resource "aws_security_group" "application_outbound" {
  name = "Application_Instance_Out"
  vpc_id = "${var.M_FRONT_VPC_ID}"

  tags {
     Name = "${var.ENVIRONMENT}-Application_Instance_Out"
  }
}

resource "aws_security_group_rule" "application_http_out" {
  security_group_id = "${aws_security_group.application_outbound.id}"
  type = "egress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "application_https_out" {
  security_group_id = "${aws_security_group.application_outbound.id}"
  type = "egress"
  from_port = 443
  to_port = 443
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}
