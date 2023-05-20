resource "null_resource" "appsync_rds_datasource" {

  triggers = {
    appsync_api_id = aws_appsync_graphql_api.appsync_api.id
    appsync_region = var.region
  }
  provisioner "local-exec" {
    command = "aws appsync create-data-source --api-id ${aws_appsync_graphql_api.appsync_api.id} --name AuroraRDS --type RELATIONAL_DATABASE --relational-database-config \"relationalDatabaseSourceType=RDS_HTTP_ENDPOINT,rdsHttpEndpointConfig={awsRegion=${var.rds_database_region},dbClusterIdentifier=${var.rds_cluster_arn},databaseName=${var.rds_database_name},awsSecretStoreArn=${var.rds_secret}}\" --service-role-arn ${var.appsync_role} --region ${var.region}"
  }

  provisioner "local-exec" {
    when       = destroy
    command    = "aws appsync delete-data-source --api-id ${self.triggers.appsync_api_id} --name AuroraRDS --region ${self.triggers.appsync_region}"
    on_failure = continue
  }
}

resource "aws_appsync_datasource" "cognito_user_lambda" {
  provider = aws.useast

  api_id   = aws_appsync_graphql_api.appsync_api.id
  name     = "CognitoUser"
  type     = "AWS_LAMBDA"

  lambda_config {
    function_arn = var.cognito_user_lambda
  }

  service_role_arn = var.appsync_role
}