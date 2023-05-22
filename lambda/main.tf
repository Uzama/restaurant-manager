provider "aws" {
  alias = "useast"
}

resource "aws_lambda_function" "cognito-user" {
  provider = aws.useast
  
  function_name    = "cognito-user-function"
  role             = var.lambda_role
  handler          = "main"
  runtime          = "go1.x"
  memory_size      = 128
  timeout          = 10
  filename         = "${path.module}/cognito-user-go/cognito-user.zip"

  environment {
    variables = {
      COGNITO_CLIENT_ID = var.cognito_client_id
      COGNITO_USER_POOL = var.cognito_user_pool_id
    }
  }
}