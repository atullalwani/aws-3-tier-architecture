# resource "aws_security_group" "ssh_external" {
#   name = "SSH_External_In"
#   vpc_id = "${aws_vpc.default.id}"
#
#   ingress {
#     from_port = 22
#     to_port = 22
#     protocol = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   tags {
#     Name = "${var.ENVIRONMENT}_SSH_External_In"
#   }
# }

resource "aws_security_group" "bastion_instance" {
  name = "Bastion_Instance"
  vpc_id = "${aws_vpc.default.id}"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.ENVIRONMENT}_Bastion_Instance"
  }
}
#
# resource "aws_security_group" "bastion_out" {
#   name = "Bastion_Out"
#   vpc_id = "${aws_vpc.default.id}"
#
#   egress {
#     from_port = 80
#     to_port = 80
#     protocol = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#
#   tags {
#     Name = "${var.ENVIRONMENT}_Bastion_Out"
#   }
# }

resource "aws_security_group" "ssh_private_out" {
  name = "SSH_Private_Out"
  vpc_id = "${aws_vpc.default.id}"

  tags {
    Name = "${var.ENVIRONMENT}_SSH_Private_Out"
  }
}

resource "aws_security_group_rule" "ssh_private_out" {
  security_group_id = "${aws_security_group.ssh_private_out.id}"
  type = "egress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.ssh_private_in.id}"
}

resource "aws_security_group" "ssh_private_in" {
  name = "SSH_Private_In"
  vpc_id = "${aws_vpc.default.id}"

  tags {
    Name = "${var.ENVIRONMENT}_SSH_Private_In"
  }
}

resource "aws_security_group_rule" "ssh_private_in" {
  security_group_id = "${aws_security_group.ssh_private_in.id}"
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.ssh_private_out.id}"
}
