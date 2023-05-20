resource "aws_appsync_function" "create_cognito_user_lambda" {
  provider                  = aws.useast
  api_id                    = aws_appsync_graphql_api.appsync_api.id
  name                      = "CreateCognitoUser"
  data_source               = aws_appsync_datasource.cognito_user_lambda.name
  depends_on                = [null_resource.appsync_rds_datasource]
  request_mapping_template  = data.local_file.create_cognito_user_request.content
  response_mapping_template = data.local_file.create_cognito_user_response.content
}

resource "aws_appsync_function" "create_restaurant_function" {
  provider          = aws.useast
  api_id            = aws_appsync_graphql_api.appsync_api.id
  data_source       = "AuroraRDS"
  depends_on        = [null_resource.appsync_rds_datasource]
  name             = "createRestaurantFunction"
  request_mapping_template  = data.local_file.create_restaurant_request.content
  response_mapping_template = data.local_file.create_restaurant_response.content
}