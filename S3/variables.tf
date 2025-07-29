variable "aws_s3" {
  type = object({
    bucket_name                = string
    force_destroy         = string
    tags                   = map(string)
  })
}