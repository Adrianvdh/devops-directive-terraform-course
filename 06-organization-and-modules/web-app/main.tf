terraform {
  # Assumes s3 bucket and dynamo DB table already set up
  # See /code/03-basics/aws-backend
  backend "s3" {
    bucket         = "devops-directive-terraform-state" # REPLACE WITH YOUR BUCKET NAME
    key            = "06-organization-and-modules/web-app/terraform.tfstate"
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
  region           = "af-south-1"
  bucket_prefix    = "web-app-1-data"
  domain           = "devopsdeployed.com"
  app_name         = "web-app-1"
  environment_name = "production"
  instance_type    = "t3.small"
  create_dns_zone  = true
  db_name          = "webapp1db"
  db_user          = "foo"
  # db_pass          = var.db_pass_1
  db_pass = "SuperSecurePassword"
  db_instance_type = "db.t3.small"
}

module "web_app_2" {
  source = "../web-app-module"

  # Input Variables
  region           = "af-south-1"
  bucket_prefix    = "web-app-2-data"
  domain           = "anotherdevopsdeployed.com"
  app_name         = "web-app-2"
  environment_name = "production"
  instance_type    = "t3.small"
  create_dns_zone  = true
  db_name          = "webapp2db"
  db_user          = "bar"
  # db_pass          = var.db_pass_2
  db_pass = "SuperSecurePassword"
  db_instance_type = "db.t3.small"
}
