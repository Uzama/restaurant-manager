variable "region" {
  description = "AWS region."
  default     = "eu-west-1"
}

variable "appsync_role" {
  description = "AWS IAM Role ARN for appsync"
  default     = ""
}

variable "auth_type" {
  description = "AppSync Auth type"
  default     = "AMAZON_COGNITO_USER_POOLS"
}

variable "appsync_name" {
  description = "resource name"
  default     = "restaurant-manager"
}

variable "rds_database_region" {
  type        = string
  default     = "us-east-1"
  description = "Aurora RDS database region"
}

variable "user_pool" {
  description = "Cognito user pool id to connect"
  default     = "no-userpool"
}

variable "client" {
  description = "Cognito user pool id to connect"
  default     = "no-client"
}

variable "rds_cluster_arn" {
  type        = string
  default     = "no-arn"
  description = "Aurora RDS Cluster ARN"
}

variable "rds_database_name" {
  type        = string
  default     = "no-name"
  description = "Aurora RDS DB Name"
}

variable "rds_secret" {
  type        = string
  default     = "no-arn"
  description = "ARN from secret store to allow RDS Datasource to connect"
}