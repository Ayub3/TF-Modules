resource "aws_s3_bucket" "bucket" {
  bucket = var.aws_s3.bucket_name
  force_destroy = var.aws_s3.force_destroy
  

   tags = {
    Name = merge(var.aws_s3_bucket.tags, local.tags)
  }
}