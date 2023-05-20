output "cognito_user" {
  value = {
    arn           = aws_lambda_function.cognito-user.arn
    function_name = aws_lambda_function.cognito-user.function_name
  }
}