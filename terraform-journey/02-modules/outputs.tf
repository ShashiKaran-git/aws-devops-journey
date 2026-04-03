output "bucket_name" {
    description = "Name of the created bucket"
    value       = module.s3_bucket.bucket_name
}

output "bucket_arn" {
    description = "ARN of the created bucket"
    value       = module.s3_bucket.bucket_arn
}