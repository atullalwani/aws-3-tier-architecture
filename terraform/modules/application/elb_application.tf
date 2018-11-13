resource "aws_elb" "elb_application" {
  name = "application-elb"
  security_groups = ["${aws_security_group.application_elb_inbound.id}","${aws_security_group.application_elb_outbound.id}"]
  subnets = ["${aws_subnet.private.*.id}"]
  internal = true

  listener {
    instance_port = 443
    instance_protocol = "tcp"
    lb_port = 443
    lb_protocol = "tcp"
  }

  listener {
    instance_port = 80
    instance_protocol = "tcp"
    lb_port = 80
    lb_protocol = "tcp"
  }

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 10
    timeout = 10
    target = "TCP:80"
    interval = 30
  }

  idle_timeout = 60
  connection_draining = true
  connection_draining_timeout = 120

  tags {
    Name = "${var.ENVIRONMENT}-application_elb"
  }
}
