
terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~>6.0"
    }
  }
  backend "s3" {
    bucket = "saas-pme-tf-state"
    key = "tf-state-deploy"
    workspace_key_prefix = "tf-state-deploy-env"
    region = "us-east-1"
    encrypt = true
    use_lockfile = true
  }
}

provider "aws" {
    region = "us-east-1"
    default_tags {
      tags = {
        Environment = terraform.workspace
        Project = var.Project
        Contact = var.Contact
        ManageBy = "Terraform/deploy"
      }
    }
  
}

