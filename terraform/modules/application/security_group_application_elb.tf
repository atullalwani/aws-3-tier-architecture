resource "aws_security_group" "application_elb_inbound" {
  name = "Application_ELB_Inbound"
  vpc_id = "${var.M_FRONT_VPC_ID}"

  tags {
    Name = "${var.ENVIRONMENT}-Elb_Application_Inbound"
  }
}

resource "aws_security_group_rule" "application_elb_https_in" {
  security_group_id = "${aws_security_group.application_elb_inbound.id}"
  type = "ingress"
  from_port = 443
  to_port = 443
  protocol = "tcp"
  source_security_group_id = "${var.M_FRONT_PROXY_OUTBOUND_ID}"
}

resource "aws_security_group_rule" "application_elb_http_in" {
  security_group_id = "${aws_security_group.application_elb_inbound.id}"
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  source_security_group_id = "${var.M_FRONT_PROXY_OUTBOUND_ID}"
}

resource "aws_security_group" "application_elb_outbound" {
  name = "Application_ELB_Outbound"
  vpc_id = "${var.M_FRONT_VPC_ID}"

  tags {
    Name = "${var.ENVIRONMENT}-Application_ELB_Outbound"

  }
}

resource "aws_security_group_rule" "application_elb_outbound_http" {
  security_group_id = "${aws_security_group.application_elb_outbound.id}"
  type = "egress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.application_inbound.id}"
}

resource "aws_security_group_rule" "application_elb_outbound_https" {
  security_group_id = "${aws_security_group.application_elb_outbound.id}"
  type = "egress"
  from_port = 443
  to_port = 443
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.application_inbound.id}"
}
