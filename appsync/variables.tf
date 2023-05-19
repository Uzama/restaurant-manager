variable "region" {
  description = "AWS region."
  default     = "eu-west-1"
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