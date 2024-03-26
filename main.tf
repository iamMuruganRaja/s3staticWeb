# Create the S3 Bucket 
resource "aws_s3_bucket" "mybuc" {
    bucket = var.bucket
}

#Bucket ownership 
resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.mybuc.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# Bucket Public Access 
resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.mybuc.id 
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}


# Bucket acl setup 

resource "aws_s3_bucket_acl" "example" {
  depends_on = [
    aws_s3_bucket_ownership_controls.example,
    aws_s3_bucket_public_access_block.example,
  ]

  bucket = aws_s3_bucket.mybuc.id
  acl    = "public-read"
}

# Add Files
resource "aws_s3_object" "index" {
  bucket = aws_s3_bucket.mybuc.id
  key = "index.html"
  source = "index.html"
  acl = "public-read"
  content_type = "text/html"
}

resource "aws_s3_object" "error" {
  bucket = aws_s3_bucket.mybuc.id
  key = "error.html"
  source = "error.html"
  acl = "public-read"
  content_type = "text/html"
}

# S3 Static Website Config
resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.mybuc.id
  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "error.html"
  }
}
