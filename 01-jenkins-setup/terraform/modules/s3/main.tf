# Create S3 bucket
resource "aws_s3_bucket" "mys3-project" {
  bucket = var.bucket
  tags      = {
    Name    = "${var.project_name}-${var.environment}-s3"
  }
}

resource "aws_s3_bucket_ownership_controls" "mys3-project" {
  bucket = aws_s3_bucket.mys3-project.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "mys3-project" {
  depends_on = [aws_s3_bucket_ownership_controls.mys3-project]

  bucket = aws_s3_bucket.mys3-project.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "mys3project-versioning" {
  bucket = aws_s3_bucket.mys3-project.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "mys3project-encryption" {
  bucket = aws_s3_bucket.mys3-project.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "AES256"
    }
  }
}


# Create dynamo db
resource "aws_dynamodb_table" "s3statelocking" {
  name             = "state-lockDB"
  hash_key         = "LockID"
  billing_mode     = "PAY_PER_REQUEST"
  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"

  attribute {
    name = "LockID"
    type = "S"
  }
}
