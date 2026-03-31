output "bucket_name" {
    description = "Name of the created s3 bucket"
    value       = aws_s3_bucket.my_first_bucket.id
}

output "bucket_arn" {
    description = "ARN of the created s3 bucket"
    value       = aws_s3_bucket.my_first_bucket.arn
}

output "bucket_region" {
    description = "Region where bucket was created"
    value       = aws_s3_bucket.my_first_bucket.region
}