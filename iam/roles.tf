# Needed for appsync logging.
resource "aws_iam_role" "appsync-role" {
  name        = "restaurant-manager-appsync"
  description = "IAM Role for Sputnik appsync logging"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "appsync.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

}