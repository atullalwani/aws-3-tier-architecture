resource "aws_key_pair" "deploy_key" {
  key_name = "${var.ENVIRONMENT}_Deploy_Key"
  public_key = "${file(var.DEPLOY_KEY)}"
}

resource "aws_instance" "server_bastion" {
  count = 1
  ami = "${lookup(var.AMI_UBUNTU, var.AWS_REGION)}"
  instance_type = "${var.INSTANCETYPE_BASTION}"
  subnet_id = "${element(aws_subnet.public.*.id, count.index)}"
  key_name = "${aws_key_pair.deploy_key.id}"
  associate_public_ip_address = true
  source_dest_check = false

  vpc_security_group_ids = [
    "${aws_security_group.ssh_private_out.id}",
    "${aws_security_group.bastion_instance.id}",
    # "${var.M_DB_PUBLIC_DATABASE_ID}"
    ]

  root_block_device = {
    delete_on_termination = true
  }

  tags {
    Name = "${var.ENVIRONMENT}-Server_Bastion_${count.index}"
  }

}
