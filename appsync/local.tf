data "local_file" "appsync_schema" {
  filename = "appsync/appsync-schema.graphql"
}

data "local_file" "get_menue_request" {
  filename = "${path.module}/templates/get_menue_request.vtl"
}

data "local_file" "get_menue_response" {
  filename = "${path.module}/templates/get_menue_response.vtl"
}

data "local_file" "add_menue_item_request" {
  filename = "${path.module}/templates/add_menue_item_request.vtl"
}

data "local_file" "add_menue_item_response" {
  filename = "${path.module}/templates/add_menue_item_response.vtl"
}

data "local_file" "delete_menue_item_request" {
  filename = "${path.module}/templates/delete_menue_item_request.vtl"
}

data "local_file" "delete_menue_item_response" {
  filename = "${path.module}/templates/delete_menue_item_response.vtl"
}

data "local_file" "create_restaurant_request" {
  filename = "${path.module}/templates/create_restaurant_request.vtl"
}

data "local_file" "create_restaurant_response" {
  filename = "${path.module}/templates/create_restaurant_response.vtl"
}

data "local_file" "create_cognito_user_request" {
  filename = "${path.module}/templates/create_cognito_user_request.vtl"
}

data "local_file" "create_cognito_user_response" {
  filename = "${path.module}/templates/create_cognito_user_response.vtl"
}

data "local_file" "pipeline_before_request" {
  filename = "${path.module}/templates/pipeline_before_request.vtl"
}

data "local_file" "pipeline_after_request" {
  filename = "${path.module}/templates/pipeline_after_request.vtl"
}

data "local_file" "list_restaurant_request" {
  filename = "${path.module}/templates/list_restaurant_request.vtl"
}

data "local_file" "list_restaurant_response" {
  filename = "${path.module}/templates/list_restaurant_response.vtl"
}