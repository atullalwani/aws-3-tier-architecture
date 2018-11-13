output "s3_access_profile_id" {
  value = "${aws_iam_instance_profile.s3_access_profile.id}"
}

output "application_elb_inbound_id" {
  value = "${aws_security_group.application_elb_inbound.id}"
}
