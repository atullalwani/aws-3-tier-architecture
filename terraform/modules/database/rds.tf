resource "aws_db_instance" "rds_db_instance" {
  identifier = "maria-db"
  name = "varun"
  allocated_storage = "${var.RDS_DB_ALLOCATED_STORAGE}"
  storage_type = "${var.RDS_STORAGE_TYPE}"
  multi_az = "${var.RDS_DB_MULTI_AZ}"
  engine = "mariadb"
  engine_version = "10.2.15"
  instance_class = "${var.RDS_DB_INSTANCE_TYPE}"
  license_model = "general-public-license"
  apply_immediately = "${var.RDS_DB_APPLY_IMMEDIATELY}"
  maintenance_window = "${var.RDS_DB_MAINTENANCE_WINDOW}"
  username = "${var.RDS_USERNAME}"
  password = "${var.RDS_PASSWORD}"
  storage_encrypted = false
  final_snapshot_identifier = "maria-db-final-snapshot"
  skip_final_snapshot = "${var.RDS_SKIP_FINAL_SNAPSHOT}"
  copy_tags_to_snapshot = true
  backup_retention_period = "${var.RDS_BACKUP_RETENTION_PERIOD}"
  backup_window = "${var.RDS_DB_BACKUP_WINDOW}"
  db_subnet_group_name = "${aws_db_subnet_group.rds_subnets.id}"
  vpc_security_group_ids = [
    "${aws_security_group.private_database_in.id}",
    "${aws_security_group.public_database_in.id}"
  ]

  tags {
    Name = "Maria_DB"
  }
}
