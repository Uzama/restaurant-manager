provider "aws" {
  region = "eu-central-1"
}
provider "aws" {
  alias = "useast"
  region = "us-east-1"
}

module "database" {
  source = "./database"

  providers = {
    aws = aws
    aws.useast = aws.useast
  }
}