variable "cluster_name" {
  type = string
  default = "restaurant-manager"
}

variable "database_name" {
  type = string
  default = "restaurant"
}

variable "password" {
  type    = string
  default = "password"
}

variable "db_subnet_group_name" {
  type    = string
  default = "default"
}

variable "username" {
  type    = string
  default = "admin"
}

variable "revision" {
  description = "Component Tag"
  default     = "Manual"
}
