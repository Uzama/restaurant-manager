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