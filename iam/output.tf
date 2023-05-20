output "appsync-role-arn" {
  value = aws_iam_role.appsync-role.arn
}

output "lambda-role-arn" {
  value = aws_iam_role.lambda-role.arn
}