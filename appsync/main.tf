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
    aws_region     = var.region
    default_action = "ALLOW"
    user_pool_id   = var.user_pool
  }

  schema = data.local_file.appsync_schema.content
}