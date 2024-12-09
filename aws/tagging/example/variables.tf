variable "aws_region" {
  type        = string
  description = "(Required) AWS region where the assets will be deployed"
  default     = "us-east-1"
}
variable "aws_profile" {
  type        = string
  description = "(Optional) AWS Profile to provider"
  default     = "default"
}
