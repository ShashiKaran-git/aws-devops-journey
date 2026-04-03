terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 5.0"
        }
    }
}

provider "aws" {
    region = "ap-south-1"
}

resource "aws_s3_bucket" "terraform_state" {
    bucket = "shashi-terraform-state-2026"

    tags = {
        Name      = "TerraformState"
        ManagedBy = "terraform"
    }
}

resource "aws_s3_bucket_versioning" "terraform_state" {
    bucket = aws_s3_bucket.terraform_state.id

    versioning_configuration {
        status = "Enabled"
    }
}

resource "aws_dynamodb_table" "terraform_locks" {
    name         = "terraform-state-locks"
    billing_mode = "PAY_PER_REQUEST"
    hash_key     =  "LockID"

    attribute {
        name = "LockID"
        type = "S"
    }

    tags = {
        Name      = "TerraformStateLocks"
        ManagedBy = "terraform"
    }
}