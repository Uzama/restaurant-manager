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
  kind              = "PIPELINE"
  field             = "createRestaurant"
  request_template  = data.local_file.pipeline_before_request.content
  response_template = data.local_file.pipeline_after_request.content
  type              = "Mutation"

  pipeline_config {
    functions = [
      aws_appsync_function.create_cognito_user_lambda.function_id,
      aws_appsync_function.create_restaurant_function.function_id
    ]
  }
}

resource "aws_appsync_resolver" "login" {
  provider          = aws.useast
  api_id            = aws_appsync_graphql_api.appsync_api.id
  kind              = "PIPELINE"
  field             = "login"
  request_template  = data.local_file.pipeline_before_request.content
  response_template = data.local_file.pipeline_after_request.content
  type              = "Mutation"

  pipeline_config {
    functions = [
      aws_appsync_function.login_function.function_id
    ]
  }
}

resource "aws_appsync_resolver" "get_restaurant" {
  provider          = aws.useast
  api_id            = aws_appsync_graphql_api.appsync_api.id
  data_source       = "AuroraRDS"
  depends_on        = [null_resource.appsync_rds_datasource]
  field             = "getRestaurant"
  request_template  = data.local_file.get_restaurant_request.content
  response_template = data.local_file.get_restaurant_response.content
  type              = "Query"
}

resource "aws_appsync_resolver" "delete_restaurant" {
  provider          = aws.useast
  api_id            = aws_appsync_graphql_api.appsync_api.id
  kind              = "PIPELINE"
  field             = "deleteRestaurant"
  request_template  = data.local_file.pipeline_before_request.content
  response_template = data.local_file.pipeline_after_request.content
  type              = "Mutation"

  pipeline_config {
    functions = [
      aws_appsync_function.delete_cognito_user_lambda.function_id,
      aws_appsync_function.delete_restaurant_function.function_id
    ]
  }
}

resource "aws_appsync_resolver" "create_order" {
  provider          = aws.useast
  api_id            = aws_appsync_graphql_api.appsync_api.id
  data_source       = "AuroraRDS"
  depends_on        = [null_resource.appsync_rds_datasource]
  field             = "createOrder"
  request_template  = data.local_file.create_order_request.content
  response_template = data.local_file.create_order_response.content
  type              = "Mutation"
}

resource "aws_appsync_resolver" "list_order" {
  provider          = aws.useast
  api_id            = aws_appsync_graphql_api.appsync_api.id
  data_source       = "AuroraRDS"
  depends_on        = [null_resource.appsync_rds_datasource]
  field             = "listOrder"
  request_template  = data.local_file.list_order_request.content
  response_template = data.local_file.list_order_response.content
  type              = "Query"
}

resource "aws_appsync_resolver" "delete_order" {
  provider          = aws.useast
  api_id            = aws_appsync_graphql_api.appsync_api.id
  data_source       = "AuroraRDS"
  depends_on        = [null_resource.appsync_rds_datasource]
  field             = "deleteOrder"
  request_template  = data.local_file.delete_order_request.content
  response_template = data.local_file.delete_order_response.content
  type              = "Mutation"
}

resource "aws_appsync_resolver" "add_order_item" {
  provider          = aws.useast
  api_id            = aws_appsync_graphql_api.appsync_api.id
  data_source       = "AuroraRDS"
  depends_on        = [null_resource.appsync_rds_datasource]
  field             = "addOrderItem"
  request_template  = data.local_file.add_order_item_request.content
  response_template = data.local_file.add_order_item_response.content
  type              = "Mutation"
}

resource "aws_appsync_resolver" "update_order_item" {
  provider          = aws.useast
  api_id            = aws_appsync_graphql_api.appsync_api.id
  data_source       = "AuroraRDS"
  depends_on        = [null_resource.appsync_rds_datasource]
  field             = "updateOrderItem"
  request_template  = data.local_file.update_order_item_request.content
  response_template = data.local_file.update_order_item_response.content
  type              = "Mutation"
}

resource "aws_appsync_resolver" "remove_order_item" {
  provider          = aws.useast
  api_id            = aws_appsync_graphql_api.appsync_api.id
  data_source       = "AuroraRDS"
  depends_on        = [null_resource.appsync_rds_datasource]
  field             = "removeOrderItem"
  request_template  = data.local_file.remove_order_item_request.content
  response_template = data.local_file.remove_order_item_response.content
  type              = "Mutation"
}

resource "aws_appsync_resolver" "create_invoice" {
  provider          = aws.useast
  api_id            = aws_appsync_graphql_api.appsync_api.id
  data_source       = "AuroraRDS"
  depends_on        = [null_resource.appsync_rds_datasource]
  field             = "createInvoice"
  request_template  = data.local_file.create_invoice_request.content
  response_template = data.local_file.create_invoice_response.content
  type              = "Mutation"
}

resource "aws_appsync_resolver" "list_invoice" {
  provider          = aws.useast
  api_id            = aws_appsync_graphql_api.appsync_api.id
  data_source       = "AuroraRDS"
  depends_on        = [null_resource.appsync_rds_datasource]
  field             = "listInvoice"
  request_template  = data.local_file.list_invoice_request.content
  response_template = data.local_file.list_invoice_response.content
  type              = "Query"
}