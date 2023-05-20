locals {
  secret = {
    username            = var.username
    password            = var.password
    engine              = "mysql"
    host                = aws_rds_cluster.cluster.endpoint
    port                = 3306
    dbClusterIdentifier = var.cluster_name
  }

  secret_content = jsonencode(local.secret)
}

resource "aws_secretsmanager_secret" "restaurant" {
  provider = aws.useast

  description             = "RDS database ${var.username} credentials for ${var.cluster_name}"
  name                    = "${var.cluster_name}-secret"
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "restaurant" {
  provider = aws.useast

  secret_id     = aws_secretsmanager_secret.restaurant.id
  secret_string = local.secret_content
}

resource "aws_ssm_parameter" "rds-secret" {
  name  = "/restaurant/secrets/aurora/arn"
  type  = "String"
  value = aws_secretsmanager_secret_version.restaurant.arn
}