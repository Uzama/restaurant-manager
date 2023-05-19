output "cluster_arn" {
  value = aws_rds_cluster.cluster.arn
}

output "database_name" {
  value = aws_rds_cluster.cluster.database_name
}

output "rds_secret" {
  value = aws_secretsmanager_secret.restaurant.arn
}

output "cluster_endpoint" {
  value = aws_rds_cluster.cluster.endpoint
}

output "master_password" {
  value = aws_rds_cluster.cluster.master_password
}

output "master_username" {
  value = aws_rds_cluster.cluster.master_username
}
