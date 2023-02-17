terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region                   = "sa-east-1"
  shared_credentials_files = ["/Users/cristhiannrodrigues/.aws/credentials"]
  profile                  = "gazela"
}