provider "aws" {
  alias   = "database"
  region  = var.region
}

resource "aws_rds_cluster" "cluster" {
  provider = aws.database

  cluster_identifier      = var.cluster_name
  engine_mode             = "serverless"
  engine                  = "aurora-mysql"
  engine_version          = "5.7.mysql_aurora.2.07.1"
  database_name           = var.database_name
  db_subnet_group_name    = var.db_subnet_group_name
  master_username         = var.username
  master_password         = var.password
  skip_final_snapshot     = true
  enable_http_endpoint    = true
  backup_retention_period = 7

  tags = {
    name = "restaurant manager"
  }

  lifecycle {
    ignore_changes = [engine_version]
  }
}
