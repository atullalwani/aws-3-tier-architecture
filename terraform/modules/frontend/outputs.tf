output "vpc_id"{
  value = "${aws_vpc.default.id}"
}
output "nat_gateway_id"{
  value = "${aws_nat_gateway.nat_gateway.*.id}"
}
output "proxy_outbound_id" {
  value = "${aws_security_group.proxy_instance.id}"
}
output "ssh_private_in_id"{
  value = "${aws_security_group.ssh_private_in.id}"
}

# output "app_url"{
#   value = "${aws_elb.elb_inbound.dns_name}"
# }
