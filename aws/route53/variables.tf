variable "region" {
  type        = string
  description = "(Required) AWS region to provider"
}
variable "profile" {
  type        = string
  description = "(Optional) AWS Profile to provider"
  default     = "default"
}

variable "tags" {
  default     = {}
  type        = map(string)
  description = "(Optional) the tags to add to created resources"
}
variable "tags_enabled" {
  type        = bool
  default     = true
  description = "(Optional) Enable/Disable tags"
}

variable "aws_route53" {
  type        = any
  default     = {}
  description = <<EOT
  (Required) Configure an existing DNS or create a new one in AWS Route53.
  **Example:**
  ```
  aws_route53 = {
    aws_region_parent  = ""     (Optional) Parent region of the registered AWS Route Hosted Zone.
    aws_profile_parent = ""     (Optional) Parent profile of the registered AWS Route Hosted Zone.
    register_name = {           (Required) Unique map identifier.
      private_zone     = false  (Optional) Default: true. Informs whether the DNS is private or not.
      parent_dns_name  = ""     (Optional) Parent DNS of the registered AWS Route Hosted Zone.
      record_dns_names = []     (Required) List of domains that will be registered in the module's main profile. May or may not be the same as the Parent DNS record.
    }
  }
  ```
  EOT
}
