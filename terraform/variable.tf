variable "AWS_PROFILE" {
  description = "Profile which is used to create resources on aws."
  default = "reflex"
}

variable "ENVIRONMENT" {
  description = "Name of the environment."
  default = "dev"
}

variable "AWS_REGION" {
  description = "Region where aws resources are to be created."
  default = "ap-south-1"
}

variable "AVAILABILITY_ZONE" {
  description = "Avalibility Zone for Zone A Networks"
  default = ["a","b"]
  type = "list"
}

variable "VPC_CIDR" {
  description = "CIDR for VPC"
  default = "172.20.0.0/21"
}

variable "PUBLIC_SUBNET_CIDR" {
  description = "CIDR for public subnet."
  default = ["172.20.1.0/24", "172.20.2.0/24"]
  type = "list"
}


variable "PRIVATE_SUBNET_CIDR" {
  description = "CIDR for private subnet."
  default = ["172.20.3.0/24", "172.20.4.0/24"]
  type = "list"
}

variable "DATABASE_SUBNET_CIDR" {
  description = "CIDR for database subnet."
  default = ["172.20.5.0/24", "172.20.6.0/24"]
  type = "list"
}

variable "INSTANCETYPE_BASTION" {
  description = "Instance type for astion server."
  default = "t2.micro"
}

variable "SERVER_PROXY_EC2_INSTANCE_TYPE" {
  description = "Instance type for proxy instances."
  default = "t2.micro"
}

variable "AMI_UBUNTU" {

  description = "Base AMI wth which to launch default UBUNTU instances with"
  default = {
    ap-south-1 = "ami-0d773a3b7bb2bb1c1"
  }
}
variable "PUBLIC_SUBNET_TAGS" {
  description = "TAGS for public subnet."
  type = "list"
  default = ["hello"]
}

variable "PRIVATE_SUBNET_TAGS" {
  description = "TAGS for private subnet."
  type = "list"
  default = ["hello"]
}

variable "DATABASE_SUBNET_TAGS" {
  description = "TAGS for database subnet."
  type = "list"
  default = ["hello"]
}

variable "RDS_USERNAME" {
  description = "The RDS username"
  default = "codiats"
}

variable "RDS_PASSWORD" {
  description = "The RDS password"
  default = "CodiTas123#"
}

variable "RDS_DB_BACKUP_WINDOW" {
  description = "The RDS backup window at UTC"
  default = "23:45-00:15"
}

variable "RDS_DB_MAINTENANCE_WINDOW" {
  description = "The RDS maintenance window at UTC."
  default = "sun:22:00-sun:22:30"
}

variable "RDS_DB_APPLY_IMMEDIATELY" {
  description = "This value is set to true by default by this project (AWS default is false)."
  default = "true"
}

variable "RDS_DB_MULTI_AZ" {
  description = "This value add 2 synchronous read replicas for DB in availability zones."
  default = "false"
}

variable "RDS_SKIP_FINAL_SNAPSHOT" {
  description = "This value defines whether a final db snapshot will be taken or not."
  default = "true"
}

variable "RDS_DB_ALLOCATED_STORAGE" {
  description = "This value sets the size of database instance (in GBs)."
  default = "20"
}

variable "RDS_DB_INSTANCE_TYPE" {
  description = "This value sets the InstanceType."
  default = "db.t2.micro"
}

variable "RDS_BACKUP_RETENTION_PERIOD" {
  description = "This value sets the number of days till automated backup is kept."
  default = "1"
}

variable "RDS_STORAGE_TYPE" {
  description = "This value sets the storage type for DB."
  default = "gp2"
}

variable "INSTALL_APPLICATION" {
  description = "Holds path for file which installs application on application servers."
  default = "../utility_scripts/installApplication.sh"
}

variable "INSTALL_PROXY_SERVER" {
  description = "Holds path for file which installs proxy on proxy servers."
  default = "../utility_scripts/installProxyServer.sh"
}

variable "INTERNAL_HOSTED_ZONE" {
  description = "Internal hosted zone for mapping internal elb dns name."
  default = "coditasapp.com"
}

variable "DEPLOY_KEY" {
  description = "The SSH Key to use for deployments for hosts."
  default = "../configs/dev/dev_deploy_key.pub"
}

variable "S3_BUCKET_NAME" {
  description = "Bucket where nginx conf for proxy and app are stored."
  default = "coditas-assessment-task-2"
}
