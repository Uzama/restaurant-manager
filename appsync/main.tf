provider "aws" {
  alias = "useast"
}

resource "aws_appsync_graphql_api" "appsync_api" {
  provider = aws.useast

  authentication_type = var.auth_type
  name                = var.appsync_name

  additional_authentication_provider {
    authentication_type = "API_KEY"
  }

  user_pool_config {
    aws_region               = var.region
    default_action           = "ALLOW"
    user_pool_id             = var.user_pool
    app_id_client_regex      = var.client
  }

  provisioner "local-exec" {
    command = <<EOT
      aws ssm put-parameter --overwrite --name /${var.appsync_name}/appsync/graphql/cognito/id --type String --value ${aws_appsync_graphql_api.appsync_api.id} --region ${var.region}
      aws ssm put-parameter --overwrite --name /${var.appsync_name}/appsync/graphql/cognito/endpoint --type String --value ${aws_appsync_graphql_api.appsync_api.uris["GRAPHQL"]} --region ${var.region}
    EOT
  }

  schema = data.local_file.appsync_schema.content
}

resource "aws_appsync_api_key" "cognito_api_key" {
  provider    = aws.useast
  api_id      = aws_appsync_graphql_api.appsync_api.id
  expires     = timeadd(timestamp(), "8700h")

  provisioner "local-exec" {
    command = <<EOT
      aws ssm put-parameter --overwrite --name /${var.appsync_name}/appsync/graphql/cognito/apikey --type String --value ${aws_appsync_api_key.cognito_api_key.key} --region ${var.region}
    EOT
  }
}