resource "aws_appsync_resolver" "get_menue" {
  provider          = aws.useast
  api_id            = aws_appsync_graphql_api.appsync_api.id
  data_source       = "AuroraRDS"
  depends_on        = [null_resource.appsync_rds_datasource]
  field             = "getMenue"
  request_template  = data.local_file.get_menue_request.content
  response_template = data.local_file.get_menue_response.content
  type              = "Query"
}

resource "aws_appsync_resolver" "add_menue_item" {
  provider          = aws.useast
  api_id            = aws_appsync_graphql_api.appsync_api.id
  data_source       = "AuroraRDS"
  depends_on        = [null_resource.appsync_rds_datasource]
  field             = "addMenueItem"
  request_template  = data.local_file.add_menue_item_request.content
  response_template = data.local_file.add_menue_item_response.content
  type              = "Mutation"
}

resource "aws_appsync_resolver" "delete_menue_item" {
  provider          = aws.useast
  api_id            = aws_appsync_graphql_api.appsync_api.id
  data_source       = "AuroraRDS"
  depends_on        = [null_resource.appsync_rds_datasource]
  field             = "deleteMenueItem"
  request_template  = data.local_file.delete_menue_item_request.content
  response_template = data.local_file.delete_menue_item_response.content
  type              = "Mutation"
}

resource "aws_appsync_resolver" "create_restaurant" {
  provider          = aws.useast
  api_id            = aws_appsync_graphql_api.appsync_api.id
  data_source       = "AuroraRDS"
  depends_on        = [null_resource.appsync_rds_datasource]
  field             = "createRestaurant"
  request_template  = data.local_file.create_restaurant_request.content
  response_template = data.local_file.create_restaurant_response.content
  type              = "Mutation"
}