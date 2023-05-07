terraform {
  # Assumes s3 bucket and dynamo DB table already set up
  # See /code/03-basics/aws-backend
  backend "s3" {
    bucket         = "devops-directive-terraform-state" # REPLACE WITH YOUR BUCKET NAME
    key            = "07-managing-multiple-environments/workspaces/terraform.tfstate"
    region         = "af-south-1"
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
  region = "af-south-1"
}

# variable "db_pass" {
#   description = "password for database"
#   type        = string
#   sensitive   = true
# }

locals {
  environment_name = terraform.workspace
}

module "web_app" {
  source = "../../06-organization-and-modules/web-app-module"

  # Input Variables
  region           = "af-south-1"
  bucket_prefix    = "web-app-data-${local.environment_name}"
  domain           = "devopsdeployed.com"
  environment_name = local.environment_name
  instance_type    = "t3.small"
  create_dns_zone  = terraform.workspace == "production" ? true : false
  db_name          = "${local.environment_name}mydb"
  db_user          = "foo"
  # db_pass          = var.db_pass
  db_pass = "SuperSecurePassword"
  db_instance_type = "db.t3.small"
}
