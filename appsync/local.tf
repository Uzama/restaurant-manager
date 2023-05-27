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

data "local_file" "login_function_request" {
  filename = "${path.module}/templates/login_function_request.vtl"
}

data "local_file" "login_function_response" {
  filename = "${path.module}/templates/login_function_response.vtl"
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

data "local_file" "get_restaurant_request" {
  filename = "${path.module}/templates/get_restaurant_request.vtl"
}

data "local_file" "get_restaurant_response" {
  filename = "${path.module}/templates/get_restaurant_response.vtl"
}

data "local_file" "delete_cognito_user_lambda_request" {
  filename = "${path.module}/templates/delete_cognito_user_lambda_request.vtl"
}

data "local_file" "delete_cognito_user_lambda_response" {
  filename = "${path.module}/templates/delete_cognito_user_lambda_response.vtl"
}

data "local_file" "delete_restaurant_function_request" {
  filename = "${path.module}/templates/delete_restaurant_function_request.vtl"
}

data "local_file" "delete_restaurant_function_response" {
  filename = "${path.module}/templates/delete_restaurant_function_response.vtl"
}

data "local_file" "create_order_request" {
  filename = "${path.module}/templates/create_order_request.vtl"
}

data "local_file" "create_order_response" {
  filename = "${path.module}/templates/create_order_response.vtl"
}

data "local_file" "list_order_request" {
  filename = "${path.module}/templates/list_order_request.vtl"
}

data "local_file" "list_order_response" {
  filename = "${path.module}/templates/list_order_response.vtl"
}

data "local_file" "delete_order_request" {
  filename = "${path.module}/templates/delete_order_request.vtl"
}

data "local_file" "delete_order_response" {
  filename = "${path.module}/templates/delete_order_response.vtl"
}

data "local_file" "add_order_item_request" {
  filename = "${path.module}/templates/add_order_item_request.vtl"
}

data "local_file" "add_order_item_response" {
  filename = "${path.module}/templates/add_order_item_response.vtl"
}

data "local_file" "update_order_item_request" {
  filename = "${path.module}/templates/update_order_item_request.vtl"
}

data "local_file" "update_order_item_response" {
  filename = "${path.module}/templates/update_order_item_response.vtl"
}

data "local_file" "remove_order_item_request" {
  filename = "${path.module}/templates/remove_order_item_request.vtl"
}

data "local_file" "remove_order_item_response" {
  filename = "${path.module}/templates/remove_order_item_response.vtl"
}

data "local_file" "create_invoice_request" {
  filename = "${path.module}/templates/create_invoice_request.vtl"
}

data "local_file" "create_invoice_response" {
  filename = "${path.module}/templates/create_invoice_response.vtl"
}

data "local_file" "list_invoice_request" {
  filename = "${path.module}/templates/list_invoice_request.vtl"
}

data "local_file" "list_invoice_response" {
  filename = "${path.module}/templates/list_invoice_response.vtl"
}

data "local_file" "list_order_items_request" {
  filename = "${path.module}/templates/list_order_items_request.vtl"
}

data "local_file" "list_order_items_response" {
  filename = "${path.module}/templates/list_order_items_response.vtl"
}