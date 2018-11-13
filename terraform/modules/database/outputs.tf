output "public_database_out_id" {
  value = "${aws_security_group.public_database_out.id}"
}

output "private_database_out_id"{
  value = "${aws_security_group.private_database_out.id}"
}
