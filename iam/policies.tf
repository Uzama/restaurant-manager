resource "aws_iam_policy" "appsync-access-rds" {
  name        = "restaurant-manager-appsync-rds"
  path        = "/"
  description = "Appsync access to RDS data and secret to get user/password for database"

  policy = <<EOF
{
   "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "rds-data:DeleteItems",
                "rds-data:ExecuteSql",
                "rds-data:GetItems",
                "rds-data:InsertItems",
                "rds-data:UpdateItems",
                "rds-data:ExecuteStatement"
            ],
            "Resource": [
                "arn:aws:rds:us-east-1:*:cluster:*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "secretsmanager:GetSecretValue"
            ],
            "Resource": [
                "arn:aws:secretsmanager:us-east-1:*:secret:*"
            ]
        }
    ]
}
EOF

}

resource "aws_iam_role_policy_attachment" "appsync-logs-policy-attachment" {
  role       = aws_iam_role.appsync-role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSAppSyncPushToCloudWatchLogs"
}

resource "aws_iam_role_policy_attachment" "appsync-rds-policy-attachment" {
  role       = aws_iam_role.appsync-role.name
  policy_arn = aws_iam_policy.appsync-access-rds.arn
}