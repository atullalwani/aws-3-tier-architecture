variable "ENVIRONMENT" {

}

variable "AWS_REGION" {

}

variable "AVAILABILITY_ZONE" {
  description = "Avalibility Zone for Zone A Networks"
  type = "list"
}

variable "DATABASE_SUBNET_CIDR" {
  description = "CIDR for database subnet."
  type = "list"
}

variable "DATABASE_SUBNET_TAGS" {
  description = "TAGS for database subnet."
  type = "list"
}

variable "RDS_USERNAME" {
  description = "The RDS user"
}

variable "RDS_PASSWORD" {
  description = "The RDS password"
}

variable "RDS_DB_BACKUP_WINDOW" {
  description = "The RDS backup window at UTC"
}

variable "RDS_DB_MAINTENANCE_WINDOW" {
  description = "The RDS maintenance window at UTC"
}

variable "RDS_DB_APPLY_IMMEDIATELY" {
  description = "This value is set to true by default by this project (AWS default is false)."
}

variable "RDS_DB_MULTI_AZ" {
  description = "This value add 2 synchronous read replicas for DB in availability zones"
}

variable "RDS_SKIP_FINAL_SNAPSHOT" {
  description = "This value defines whether a final db snapshot will be taken or not"
}

variable "RDS_DB_ALLOCATED_STORAGE" {
  description = "This value sets the size of database instance (in GBs)"
}

variable "RDS_DB_INSTANCE_TYPE" {
  description = "This value sets the InstanceType"
}

variable "RDS_BACKUP_RETENTION_PERIOD" {
  description = "This value sets the number of days till automated backup is kept"
}

variable "RDS_STORAGE_TYPE" {
  description = "This value sets the storage type for DB"
}

variable "M_FRONT_VPC_ID" {
}
