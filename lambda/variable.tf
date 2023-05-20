variable "lambda_role" {
  description = "AWS IAM Role ARN for lambdas execution"
  type        = string
}

variable "cognito_client_id" {
  description = "Cognito Client ID"
  type        = string
}

variable "cognito_user_pool_id" {
  description = "User pool ID"
  type        = string
}