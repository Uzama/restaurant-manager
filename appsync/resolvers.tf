resource "aws_appsync_resolver" "list_user_groups" {
  provider          = aws.useast
  api_id            = aws_appsync_graphql_api.appsync_api.id
  data_source       = "AuroraRDS"
  depends_on        = [null_resource.appsync_rds_datasource]
  field             = "getMenue"
  request_template  = data.local_file.get_menue_request.content
  response_template = data.local_file.get_menue_response.content
  type              = "Query"
}