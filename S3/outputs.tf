output "bucket_id" {
  description = "The ID of the S3 bucket"
  value       = aws_s3_bucket.bucket.id
}

output "bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = aws_s3_bucket.bucket.arn
}

output "bucket_domain_name" {
  description = "The DNS domain name of the bucket"
  value       = aws_s3_bucket.bucket.bucket_domain_name
}

output "bucket_name" {
  description = "The name of the bucket"
  value       = aws_s3_bucket.bucket.bucket
}