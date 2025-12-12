terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~>6.0"

    }
  }
  backend "s3" {
    bucket = "saas-pme-tf-state"
    key = "tf-state-setup"
    region = "us-east-1"
    encrypt = true
    use_lockfile = true
  }
}

provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = {
    Environment = terraform.Environment
    Project = var.Project
    Contact = var.Contact
    ManageBy = "terraform/setup"
    }

  }
}

