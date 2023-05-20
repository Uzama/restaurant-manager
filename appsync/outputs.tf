output "appsync_endpoint" {
  value = aws_appsync_graphql_api.appsync_api.uris["GRAPHQL"]
}