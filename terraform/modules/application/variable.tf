variable "ENVIRONMENT" {

}

variable "AWS_REGION" {
}

variable "AVAILABILITY_ZONE" {
  description = "Avalibility Zone for Zone A Networks"
  type = "list"
}

variable "PRIVATE_SUBNET_CIDR" {
  description = "CIDR for private subnet."
  type = "list"
}

variable "PRIVATE_SUBNET_TAGS" {
  description = "TAGS for private subnet."
  type = "list"
}


variable "SERVER_PROXY_EC2_INSTANCE_TYPE" {
}

variable "AMI_UBUNTU" {
  description = "Base AMI wth which to launch default UBUNTU instances with"
  type = "map"
}

variable "INSTALL_APPLICATION" {
}

variable "INTERNAL_HOSTED_ZONE" {
}

variable "M_FRONT_NAT_GATEWAY_ID" {
  type = "list"
}

variable "M_FRONT_VPC_ID" {
}

variable "M_FRONT_PROXY_OUTBOUND_ID" {
}

variable "M_FRONT_SSH_PRIVATE_IN_ID" {
}

variable "M_DB_PRIVATE_DATABASE_ID" {
}

variable "DEPLOY_KEY" {
}

variable "S3_BUCKET_NAME" {
}
