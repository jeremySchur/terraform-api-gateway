variable "region" {
  description = "AWS region"
  type        = string
}

variable "JWT_ACCESS_SECRET" {
  description = "JWT access secret"
  type        = string
  sensitive   = true
}