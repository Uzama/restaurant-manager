provider "aws" {
  alias = "useast"
}

resource "aws_rds_cluster" "cluster" {
  provider = aws.useast

  cluster_identifier      = var.cluster_name
  engine_mode             = "serverless"
  engine                  = "aurora-mysql"
  engine_version          = "5.7.mysql_aurora.2.07.1"
  database_name           = var.database_name
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

resource "null_resource" "db_setup" {

  triggers = {
    file = filesha1("database/database.sql")
  }
  provisioner "local-exec" {
    command = <<-EOF
			while read line; do
				echo "$line"
				aws rds-data execute-statement --region "us-east-1" --resource-arn "$DB_ARN" --database  "$DB_NAME" --secret-arn "$SECRET_ARN" --sql "$line"
			done  < <(awk 'BEGIN{RS=";\n"}{gsub(/\n/,""); if(NF>0) {print $0";"}}' database/database.sql)
			EOF
    environment = {
      DB_ARN     = aws_rds_cluster.cluster.arn
      DB_NAME    = aws_rds_cluster.cluster.database_name
      SECRET_ARN = aws_secretsmanager_secret.restaurant.arn
    }
    interpreter = ["bash", "-c"]
  }
}
