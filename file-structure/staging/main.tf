terraform {
  backend "s3" {
    bucket         = "tf-state-practice-12nov"
    key            = "staging/terraform.tfstate"
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

# variable "db_pass" {
#   description = "password for database"
#   type        = string
#   sensitive   = true
# }

locals {
  environment_name = "staging"
}

module "web_app" {
  source = "../web-app-module"

  # Input Variables
  # bucket_name      = "tf-state-practice-26nov-${local.environment_name}"
  # app_name         = "web-app-1"
  # environment_name = local.environment_name
  instance_name    = "web-app-${local.environment_name}"
  instance_type    = "t2.micro"
  # db_name          = "${local.environment_name}mydb"
  # db_user          = "foo"
  # db_pass          = var.db_pass
}