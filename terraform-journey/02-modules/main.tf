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

module "s3_bucket" {
    source      = "./modules/s3-bucket"
    bucket_name = var.bucket_name
    environment = var.environment
}