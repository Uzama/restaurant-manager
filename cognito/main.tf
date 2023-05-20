provider "aws" {
  region = var.region  # Replace with your desired region
}

resource "aws_cognito_user_pool" "pool" {
  name                       = var.name
  email_verification_subject = "Reset password code"
  email_verification_message = "Your reset password validation code is: {####}"
  username_attributes        = ["email"]
  auto_verified_attributes   = ["email"]

  admin_create_user_config {
    allow_admin_create_user_only = false
  }

  email_configuration {
    reply_to_email_address = "" 
  }

  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = 1
    }
  }

  schema {
    attribute_data_type      = "String"
    name                     = "email"
    required                 = true
    developer_only_attribute = false
    mutable                  = true

    string_attribute_constraints {
      min_length = "7"
      max_length = "100"
    }
  }

  password_policy {
    minimum_length    = 8
    require_numbers   = true
    require_lowercase = true
    require_symbols   = false
    require_uppercase = true
  }

  tags = {
    Name = var.name
  }

  user_pool_add_ons {
    advanced_security_mode = "OFF"
  }

  mfa_configuration = "OPTIONAL"

  software_token_mfa_configuration {
    enabled = false
  }
}

resource "aws_cognito_user_pool_client" "client" {
  name                = var.name
  user_pool_id        = aws_cognito_user_pool.pool.id
  explicit_auth_flows = ["ADMIN_NO_SRP_AUTH", "USER_PASSWORD_AUTH"]
  generate_secret     = false
}

resource "aws_cognito_user_group" "admin" {
  name         = "admin"
  user_pool_id = aws_cognito_user_pool.pool.id
}