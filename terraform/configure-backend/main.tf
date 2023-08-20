provider "aws" {
  region = "us-west-2"
}

resource "aws_s3_bucket" "terraform-state" {
  bucket = "automate-all-things-app-terraform-back-end"
}

resource "aws_s3_bucket_public_access_block" "block" {
  bucket = aws_s3_bucket.terraform-state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_dynamodb_table" "terraform-state" {
  name           = "automate-all-things-app-terraform-back-end"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}