resource "null_resource" "sputnik_root_user" {
  depends_on = [aws_cognito_user_pool.pool]
  provisioner "local-exec" {
    command = "aws cognito-idp admin-create-user --user-pool-id ${aws_cognito_user_pool.pool.id} --username ${var.email} --user-attributes=Name=email,Value=${var.email} --region ${var.region}"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "echo 'Destroying environment. Doing nothing.'"
  }
}

resource "null_resource" "sputnik_root_user_group" {
  depends_on = [null_resource.sputnik_root_user]
  provisioner "local-exec" {
    command = "aws cognito-idp admin-add-user-to-group --user-pool-id ${aws_cognito_user_pool.pool.id} --username ${var.email} --group-name ${aws_cognito_user_group.admin.name} --region ${var.region}"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "echo 'Destroying environment. Doing nothing.'"
  }
}

resource "null_resource" "sputnik_root_user_confirm_email" {
  depends_on = [null_resource.sputnik_root_user]
  provisioner "local-exec" {
    command = "aws cognito-idp admin-set-user-password --user-pool-id ${aws_cognito_user_pool.pool.id} --username ${var.email} --password ${var.password} --permanent --region ${var.region}"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "echo 'Destroying environment. Doing nothing.'"
  }
}

resource "aws_ssm_parameter" "email" {
  name  = "/${var.name}/app/users/root/email"
  type  = "String"
  value = var.email
}

resource "aws_ssm_parameter" "password" {
  name  = "/${var.name}/app/users/root/password"
  type  = "String"
  value = var.password
}