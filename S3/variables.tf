variable "bucket_name" {
  description = "The name of the S3 bucket."
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the bucket."
  type        = map(string)
  default     = {}
}

variable "force_destroy" {
  type    = bool
  default = false
}

variable "object_lock_enabled" {
  type    = bool
  default = false
}

variable "aws_s3_bucket_ownership" {
  description = "Ownership control for objects. Options: BucketOwnerPreferred, ObjectWriter, BucketOwnerEnforced."
  type        = string
  default     = "BucketOwnerEnforced"
}

variable "block_public_acls" {
  type    = bool
  default = true
}

variable "block_public_policy" {
  type    = bool
  default = true
}

variable "ignore_public_acls" {
  type    = bool
  default = true
}

variable "restrict_public_buckets" {
  type    = bool
  default = true
}

variable "versioning_status" {
  type    = string
  default = "enabled"
}

variable "enable_sse" {
  type    = bool
  default = true
}

variable "kms_key_id" {
  type    = string
  default = null
}

variable "deletion_window_in_days" {
  type    = number
  default = 10
}

variable "enable_key_rotation" {
  type    = bool
  default = true
}

variable "lifecycle_rules" {
  description = "List of S3 lifecycle rules"
  type = list(object({
    id     = string
    status = string
    prefix = optional(string)
    tags   = optional(map(string))
    expiration = object({
      days = number
    })
  }))
  default = []
}

variable "bucket_policy_enabled" {
  description = "Whether to attach a bucket policy"
  type        = bool
  default     = false
}

variable "bucket_policy_json" {
  description = "JSON bucket policy to attach"
  type        = string
  default     = ""
}

variable "kms_key_policy_json" {
  description = "KMS key JSON policu to attach"
  type        = string
  default     = ""
}

variable "enable_website" {
  description = "Enable S3 static website hosting"
  type        = bool
  default     = false
}

variable "index_document" {
  description = "The name of the index document for the website (e.g., index.html)"
  type        = string
  default     = "index.html"
}

variable "error_document" {
  description = "The name of the error document for the website (e.g., error.html)"
  type        = string
  default     = "404.html"
}