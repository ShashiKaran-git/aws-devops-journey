variable "aws_region" {
    description = "AWS region"
    type        = string
    default     = "ap-south-1"
}

variable "bucket_name" {
    description = "Name of the s3 bucket"
    type        = string
}

variable "environment" {
    description = "Environment - dev, staging or production"
    type        = string
    default     = "dev"
}