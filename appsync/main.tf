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

  schema = data.local_file.appsync_schema.content
}

resource "aws_appsync_datasource" "media_create_customer" {
  provider = aws.useast

  api_id   = aws_appsync_graphql_api.appsync_api.id
  name     = "CognitoUser"
  type     = "AWS_LAMBDA"

  lambda_config {
    function_arn = var.cognito_user_lambda
  }

  service_role_arn = var.appsync_role
}