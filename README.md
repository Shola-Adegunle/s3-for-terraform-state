# README.md for Terraform AWS S3 and DynamoDB Configuration

This README provides the documentation for the Terraform configuration that sets up an AWS S3 bucket and a DynamoDB table. The AWS S3 bucket is named `sadey2k-tf-state-location` and is used for storing Terraform state files. The DynamoDB table, named `dev-terraform-state-locking`, is used for state locking to prevent conflicts when multiple users are modifying the same Terraform state files.

## Prerequisites

- Terraform installed
- AWS account
- AWS credentials configured at `~/.aws/credentials`

## Provider Configuration

The AWS provider is used with a version constraint of `>=5`. The configuration specifies that the AWS credentials are sourced from the file located at `~/.aws/credentials`, and the AWS region is set to `us-east-1`.

```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=5"
    }
  }
}

provider "aws" {
  profile = "profile2"
  region  = "us-east-1"
}
```

## AWS S3 Bucket Configuration

The S3 bucket, `sadey2k-tf-state-location`, is tagged with the name `sadey2k-tf-state-location` and the environment `Dev`.

```hcl
resource "aws_s3_bucket" "tf_state_location" {
  bucket = "sadey2k2-tf-state-location"

  tags = {
    Name        = "sadey2k2-tf-state-location"
    Environment = "Dev"
  }
}
```

## AWS DynamoDB Table Configuration

The DynamoDB table, `dev-terraform-state-locking`, uses the `PAY_PER_REQUEST` billing mode to minimize costs when not in use. The table has a partition key attribute named `LockID` of type string.

```hcl
resource "aws_dynamodb_table" "terraform_state_lock" {
  name         = "dev-terraform-state-locking"
  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }
}
```

## Usage

1. Initialize Terraform in the directory containing the configuration file.

   ```bash
   terraform init
   ```

2. Apply the configuration to create the S3 bucket and DynamoDB table.

   ```bash
   terraform apply
   ```

3. To destroy the resources created, run:

   ```bash
   terraform destroy
   ```

## Notes

Ensure that the user account used has the necessary permissions to create and manage S3 buckets and DynamoDB tables in AWS.

## Conclusion

This README provides the necessary documentation for setting up an AWS S3 bucket and a DynamoDB table using Terraform for managing the state files and state locking. Proper credentials and permissions are required to successfully apply this configuration.