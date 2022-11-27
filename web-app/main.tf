terraform {
  # Assumes s3 bucket and dynamo DB table already set up
  # See /code/03-basics/aws-backend
  backend "s3" {
    bucket         = "tf-state-practice-12nov"
    key            = "web-app/terraform.tfstate"
    region         = "ca-central-1"
    dynamodb_table = "terraform-state-locking"
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "ca-central-1"
}

# variable "db_pass_1" {
#   description = "password for database #1"
#   type        = string
#   sensitive   = true
# }

# variable "db_pass_2" {
#   description = "password for database #2"
#   type        = string
#   sensitive   = true
# }

module "web_app_1" {
  source = "../web-app-module"

  # Input Variables
  # bucket_name      = "tf-state-practice-26nov"
  # app_name         = "web-app-1"
  # environment_name = "production"
  instance_name    = "web-app-1"
  instance_type    = "t2.micro"
  # db_name          = "webapp1db"
  # db_user          = "foo"
  # db_pass          = var.db_pass_1
}

# module "web_app_2" {
#   source = "../web-app-module"

#   # Input Variables
#   bucket_name      = "tf-state-practice-26nov"
#   app_name         = "web-app-2"
#   environment_name = "production"
#   instance_type    = "t2.small"
#   create_dns_zone  = true
#   db_name          = "webapp2db"
#   db_user          = "bar"
#   db_pass          = var.db_pass_2
# }