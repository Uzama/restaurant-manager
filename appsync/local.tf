data "local_file" "appsync_schema" {
  filename = "appsync/appsync-schema.graphql"
}

data "local_file" "get_menue_request" {
  filename = "appsync/templates/get_menue_request.vtl"
}

data "local_file" "get_menue_response" {
  filename = "appsync/templates/get_menue_response.vtl"
}