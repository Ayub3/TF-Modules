resource "aws_s3_bucket" "bucket" {
  bucket              = var.bucket_name
  force_destroy       = var.aws_s3.force_destroy
  object_lock_enabled = var.object_lock_enabled

  tags = {
    Name = merge(var.tags, local.tags)
  }
}

resource "aws_s3_bucket_ownership_controls" "aws_s3_bucket_ownership_controls" {
  bucket = aws_s3_bucket.bucket.id

  rule {
    object_ownership = var.aws_s3_bucket_ownership
  }
}

resource "aws_s3_bucket_public_access_block" "block_public_access" {
  bucket                  = aws_s3_bucket.bucket.id
  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.bucket.id
  versioning_configuration {
    status = var.versioning_status
  }
}

resource "aws_kms_key" "s3_bucket_kms_key" {
  count                   = var.enable_sse ? 1 : 0
  deletion_window_in_days = var.deletion_window_in_days
  enable_key_rotation     = var.enable_key_rotation
  policy                  = var.kms_key_policy_json
}

resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  count  = var.enable_sse ? 1 : 0
  bucket = aws_s3_bucket.bucket.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.s3_bucket_kms_key.arn
      sse_algorithm     = var.kms_key_id != null ? "aws:kms" : "AES256"
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "lifecycle_configuration" {
  count  = length(var.lifecycle_rules) > 0 ? 1 : 0
  bucket = aws_s3_bucket.bucket.id

  dynamic "rule" {
    for_each = var.lifecycle_rules
    content {
      id     = rule.value.id
      status = rule.value.status

      dynamic "filter" {
        for_each = rule.value.prefix != null ? [rule.value] : []
        content {
          prefix = rule.value.prefix
        }
      }

      expiration {
        days = rule.value.expiration.days
      }
    }
  }
}

resource "aws_s3_bucket_website_configuration" "website" {
  count  = var.enable_website ? 1 : 0
  bucket = aws_s3_bucket.bucket.id

  index_document {
    suffix = var.index_document
  }

  error_document {
    key = var.error_document
  }
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  count      = var.bucket_policy_enabled ? 1 : 0
  bucket     = aws_s3_bucket.bucket.id
  policy     = var.bucket_policy_json
  depends_on = [aws_s3_bucket_public_access_block.block_public_access]
}