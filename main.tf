terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=5"

    }
  }
}

provider "aws" {
  #shared_credentials_files = ["~/.aws/credentials2"]
  profile = "profile2"
  region  = "us-east-1"
}

resource "aws_s3_bucket" "tf_state_location" {
  bucket        = "sadey2k2-tf-state-location"
  force_destroy = "true"


  tags = {
    Name        = "sadey2k2-tf-state-location"
    Environment = "Dev"
  }
}


resource "aws_dynamodb_table" "terraform_state_lock" {
  name         = "dev-terraform-state-locking" # Name of the DynamoDB table  
  hash_key     = "LockID"                      # Partition key attribute must be named LockID for Terraform state locking
  billing_mode = "PAY_PER_REQUEST"             # Use pay-per-request billing to minimize costs when not in use

  # Define the LockID attribute for the table  
  attribute {
    name = "LockID" # Attribute name must match the hash_key
    type = "S"      # LockID must be a string (S) attribute type
  }
}