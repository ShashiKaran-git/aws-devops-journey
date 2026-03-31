terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

resource "aws_s3_bucket" "my_first_bucket" {
  bucket = var.bucket_name

  tags = {
    Name        = "ShashiLearning"
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}