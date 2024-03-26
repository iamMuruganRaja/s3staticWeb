output "bucket_url" {
  value = aws_s3_bucket.mybuc.website_endpoint
}