terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 5.0"
        }
    }

    backend "s3" {
        bucket             = "shashi-terraform-state-2026"
        key                = "02-modules/terraform.tfstate"
        region             = "ap-south-1"
        dynamodb_table     = "terraform-state-locks"
        encrypt            = true
    }
}

provider "aws" {
    region = var.aws_region
}

module "s3_bucket" {
    source      = "./modules/s3-bucket"
    bucket_name = var.bucket_name
    environment = var.environment
}