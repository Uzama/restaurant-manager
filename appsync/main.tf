provider "aws" {
  alias   = "appsync"
  region  = var.region
}

resource "aws_appsync_graphql_api" "appsync_api" {
  provider            = aws.appsync
  authentication_type = var.auth_type
  name                = var.appsync_name

  additional_authentication_provider {
    authentication_type = "API_KEY"
  }

  schema = data.local_file.appsync_schema.content

  xray_enabled = true
}