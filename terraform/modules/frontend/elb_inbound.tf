resource "aws_elb" "elb_inbound" {
  name = "public-elb"
  security_groups = ["${aws_security_group.public_elb.id}","${aws_security_group.public_elb.id}"]
  subnets = ["${aws_subnet.public.*.id}"]
  internal = false

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
    Name = "${var.ENVIRONMENT}_inbound_elb"
  }
}
