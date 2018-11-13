variable "ENVIRONMENT" {
  description = "Name of the environment."
}

variable "AWS_REGION" {
  description = "Region where aws resources are to be created."
}

variable "AVAILABILITY_ZONE" {
  description = "Avalibility Zone for Resources like subnet etc."
  type = "list"
}

variable "VPC_CIDR" {
  description = "CIDR for VPC"
}

variable "PUBLIC_SUBNET_CIDR" {
  description = "CIDR for public subnet."
  type = "list"
}

variable "PRIVATE_SUBNET_CIDR" {
  description = "CIDR for private subnet."
  type = "list"
}

variable "PUBLIC_SUBNET_TAGS" {
  description = "TAGS for public subnet."
  type = "list"
}

variable "INSTANCETYPE_BASTION" {
  description = "AWS instance type size for bastion host (FreeIPA replica)"
}

variable "AMI_UBUNTU" {
  description = "Base AMI wth which to launch default UBUNTU instances with"
  type = "map"
}

variable "INSTALL_PROXY_SERVER" {
}

variable "SERVER_PROXY_EC2_INSTANCE_TYPE" {
  default = "t2.micro"
}
# 
# variable "M_APP_S3_ACCESS_PROFILE_ID" {
# }
#
# variable "M_APP_APPLICATION_ELB_INBOUND_ID" {
# }
#
# variable "M_DB_PUBLIC_DATABASE_ID" {
# }

variable "DEPLOY_KEY" {
}

variable "S3_BUCKET_NAME" {
}
