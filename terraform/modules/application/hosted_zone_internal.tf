resource "aws_route53_zone" "internal" {
  name = "${var.INTERNAL_HOSTED_ZONE}"
  vpc_id = "${var.M_FRONT_VPC_ID}"
}

resource "aws_route53_record" "public_elb_record" {
  zone_id = "${aws_route53_zone.internal.id}"
  name = "task1"
  type = "A"

  alias {
    name = "${aws_elb.elb_application.dns_name}"
    zone_id = "${aws_elb.elb_application.zone_id}"
    evaluate_target_health = false
  }
}
