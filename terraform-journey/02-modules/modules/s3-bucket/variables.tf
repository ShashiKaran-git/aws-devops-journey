variable "bucket_name" {
    description = "Name of the s3 bucket"
    type        = string
}

variable "environment" {
    description = "Environment - dev, staging or production"
    type        = string
}