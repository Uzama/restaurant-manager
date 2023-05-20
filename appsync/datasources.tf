resource "null_resource" "appsync_rds_datasource" {

  triggers = {
    appsync_api_id = aws_appsync_graphql_api.appsync_api.id
    appsync_region = var.region
  }
  provisioner "local-exec" {
    command = "aws appsync create-data-source --api-id ${aws_appsync_graphql_api.appsync_api.id} --name AuroraRDS --type RELATIONAL_DATABASE --relational-database-config \"relationalDatabaseSourceType=RDS_HTTP_ENDPOINT,rdsHttpEndpointConfig={awsRegion=${var.rds_database_region},dbClusterIdentifier=${var.rds_cluster_arn},databaseName=${var.rds_database_name},awsSecretStoreArn=${var.rds_secret}}\" --region ${var.region}"
  }
}