variable "bucket_name" {
  description = "Name of the S3 bucket for the static website"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-central-2"
}

variable "aws_profile" {
  description = "AWS profile to use (leave empty for default)"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
