provider "aws" {
  region = "eu-central-1"
}
provider "aws" {
  alias = "useast"
  region = "us-east-1"
}

module "iam" {
  source = "./iam"

  providers = {
    aws = aws
    aws.useast = aws.useast
  }
}

module "database" {
  source = "./database"

  providers = {
    aws = aws
    aws.useast = aws.useast
  }
}

module "cognito" {
  source = "./cognito"

  # providers = {
  #   aws = aws
  #   aws.useast = aws.useast
  # }
}

module "lambda" {
  source = "./lambda"

  lambda_role = module.iam.lambda-role-arn
  cognito_client_id = module.cognito.client_id
  cognito_user_pool_id = module.cognito.user_pool_id

  providers = {
    aws = aws
    aws.useast = aws.useast
  }
}

module "appsync" {
  source = "./appsync"

  appsync_name           = "Cognito"
  region                 = "us-east-1"
  rds_database_region    = "us-east-1"
  auth_type              = "AMAZON_COGNITO_USER_POOLS"
  user_pool              = module.cognito.user_pool_id
  client                 = module.cognito.client_id
  cognito_user_lambda    = module.lambda.cognito_user["arn"]

  rds_cluster_arn    = module.database.cluster_arn
  rds_database_name  = module.database.database_name
  rds_secret         = module.database.rds_secret
  appsync_role       = module.iam.appsync-role-arn

  providers = {
    aws = aws
    aws.useast = aws.useast
  }
}