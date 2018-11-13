provider "aws" {
  profile = "${var.AWS_PROFILE}"
  region = "${var.AWS_REGION}"
  version = "1.41.0"
}

# terraform {
#   backend "s3" {
#     bucket = "varun-practical-assessment-task1"
#     key = "terraform.tfstate"
#     region = "ap-south-1"
#     profile = "varun"
#   }
# }

module "frontend" {
  source = "modules/frontend"
  AVAILABILITY_ZONE = "${var.AVAILABILITY_ZONE}"
  VPC_CIDR = "${var.VPC_CIDR}"
  PUBLIC_SUBNET_CIDR = "${var.PUBLIC_SUBNET_CIDR}"
  PUBLIC_SUBNET_TAGS = "${var.PUBLIC_SUBNET_TAGS}"
  INSTANCETYPE_BASTION = "${var.INSTANCETYPE_BASTION}"
  AMI_UBUNTU = "${var.AMI_UBUNTU}"
  PRIVATE_SUBNET_CIDR = "${var.PRIVATE_SUBNET_CIDR}"
  INSTALL_PROXY_SERVER = "${var.INSTALL_PROXY_SERVER}"
  SERVER_PROXY_EC2_INSTANCE_TYPE = "${var.SERVER_PROXY_EC2_INSTANCE_TYPE}"
  AWS_REGION = "${var.AWS_REGION}"
  ENVIRONMENT = "${var.ENVIRONMENT}"
  DEPLOY_KEY = "${var.DEPLOY_KEY}"
  S3_BUCKET_NAME = "${var.S3_BUCKET_NAME}"
  # M_APP_S3_ACCESS_PROFILE_ID = "${module.application.s3_access_profile_id}"
  # M_APP_APPLICATION_ELB_INBOUND_ID = "${module.application.application_elb_inbound_id}"
  # M_DB_PUBLIC_DATABASE_ID = "${module.database.public_database_out_id}"
}
#
# module "application" {
#   source = "modules/application"
#   AWS_REGION = "${var.AWS_REGION}"
#   PRIVATE_SUBNET_CIDR = "${var.PRIVATE_SUBNET_CIDR}"
#   PRIVATE_SUBNET_TAGS = "${var.PRIVATE_SUBNET_TAGS}"
#   AWS_REGION = "${var.AWS_REGION}"
#   INSTALL_APPLICATION = "${var.INSTALL_APPLICATION}"
#   SERVER_PROXY_EC2_INSTANCE_TYPE = "${var.SERVER_PROXY_EC2_INSTANCE_TYPE}"
#   AVAILABILITY_ZONE = "${var.AVAILABILITY_ZONE}"
#   AMI_UBUNTU = "${var.AMI_UBUNTU}"
#   INTERNAL_HOSTED_ZONE = "${var.INTERNAL_HOSTED_ZONE}"
#   ENVIRONMENT = "${var.ENVIRONMENT}"
#   DEPLOY_KEY = "${var.DEPLOY_KEY}"
#   S3_BUCKET_NAME = "${var.S3_BUCKET_NAME}"
#   M_FRONT_NAT_GATEWAY_ID = "${module.frontend.nat_gateway_id}"
#   M_FRONT_VPC_ID = "${module.frontend.vpc_id}"
#   M_FRONT_PROXY_OUTBOUND_ID = "${module.frontend.proxy_outbound_id}"
#   M_FRONT_SSH_PRIVATE_IN_ID = "${module.frontend.ssh_private_in_id}"
#   M_DB_PRIVATE_DATABASE_ID = "${module.database.private_database_out_id}"
# }
#
#
# module "database" {
#   source = "modules/database"
#   AVAILABILITY_ZONE = "${var.AVAILABILITY_ZONE}"
#   DATABASE_SUBNET_CIDR = "${var.DATABASE_SUBNET_CIDR}"
#   DATABASE_SUBNET_TAGS = "${var.DATABASE_SUBNET_TAGS}"
#   RDS_USERNAME = "${var.RDS_USERNAME}"
#   RDS_PASSWORD = "${var.RDS_PASSWORD}"
#   RDS_DB_BACKUP_WINDOW = "${var.RDS_DB_BACKUP_WINDOW}"
#   RDS_DB_MAINTENANCE_WINDOW = "${var.RDS_DB_MAINTENANCE_WINDOW}"
#   RDS_DB_APPLY_IMMEDIATELY = "${var.RDS_DB_APPLY_IMMEDIATELY}"
#   RDS_DB_MULTI_AZ = "${var.RDS_DB_MULTI_AZ}"
#   RDS_SKIP_FINAL_SNAPSHOT = "${var.RDS_SKIP_FINAL_SNAPSHOT}"
#   RDS_DB_ALLOCATED_STORAGE = "${var.RDS_DB_ALLOCATED_STORAGE}"
#   RDS_DB_INSTANCE_TYPE = "${var.RDS_DB_INSTANCE_TYPE}"
#   RDS_BACKUP_RETENTION_PERIOD = "${var.RDS_BACKUP_RETENTION_PERIOD}"
#   RDS_STORAGE_TYPE = "${var.RDS_STORAGE_TYPE}"
#   AWS_REGION = "${var.AWS_REGION}"
#   ENVIRONMENT = "${var.ENVIRONMENT}"
#   M_FRONT_VPC_ID = "${module.frontend.vpc_id}"
# }

#
# output "app_public_url"{
#   value = "${module.frontend.app_url}"
# }
