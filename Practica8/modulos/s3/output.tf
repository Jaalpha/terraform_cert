output "s3_bucket_arn" {
  description = "ARN del s3 bucket desplegado"
  value       = aws_s3_bucket.cerberus_bucket.arn
}
