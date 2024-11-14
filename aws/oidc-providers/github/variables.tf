variable "region" {
  type        = string
  description = "(Required) AWS region to provider"
}
variable "profile" {
  type        = string
  description = "(Optional) AWS Profile to provider"
  default     = "default"
}
variable "cluster_arn_list" {
  type        = list(string)
  description = "(Optional) List of ARNs of AWS EKS Clusters"
  default     = []
}

variable "namespace_list" {
  type        = list(string)
  description = "(Optional) List of namespace of AWS EKS Clusters"
  default     = []
}
variable "ecr_name_list" {
  type        = list(string)
  description = "(Optional) List of ARNs of AWS ECR Repository"
  default     = []
}
variable "repository_lifecycle_policy" {
  type        = any
  description = "(Optional) The policy document. This is a JSON formatted `string`. See more details about [Policy Parameters](http://docs.aws.amazon.com/AmazonECR/latest/userguide/LifecyclePolicies.html#lifecycle_policy_parameters) in the official AWS docs"
  default     = {}
}
variable "repository_image_tag_mutability" {
  type        = string
  description = "The tag mutability setting for the repository. Must be one of: `MUTABLE` or `IMMUTABLE`"
  default     = "MUTABLE"

}
variable "iam_access_entries_enabled" {
  type = object({
    eks = optional(bool, false)
    ecr = optional(bool, false)
  })
  default = {
    eks = false
    ecr = false
  }
  description = "(Optional) Access entries allow IAM principals to authenticate to your cluster. Authorization to your cluster is provided by any combination of username, group names, or access policies. For more information, see [IAM access entries](https://docs.aws.amazon.com/eks/latest/userguide/access-entries.html)."
}
variable "tags" {
  default     = {}
  type        = map(string)
  description = "(Required) the tags to add to created resources"
}

variable "oidc_url" {
  type        = string
  default     = "https://token.actions.githubusercontent.com"
  description = "(Required) The URL of the identity provider. Corresponds to the iss claim."
}
variable "client_id_list" {
  type        = list(string)
  default     = ["sts.amazonaws.com"]
  description = "(Required) A list of client IDs (also known as `audiences`)."
}
variable "thumbprint_list" {
  type        = list(string)
  default     = ["6938fd4d98bab03faadb97b34396831e3780aea1"]
  description = "(Required) A list of server certificate thumbprints for the OpenID Connect (OIDC) identity provider's server certificate(s)."
}
variable "github" {
  type = list(object({
    repo   = string
    branch = string
  }))

  description = <<-EOT
  (Required) The GitHub organization name and the repository named and branch name.
  Example: `organization-name/repo-name`
  EOT
}
variable "inline_policy" {
  type = list(object({
    name   = optional(string, "")
    policy = optional(any, {})
  }))
  default     = []
  description = "(Optional) Configuration block defining an exclusive set of IAM inline policies associated with the IAM role."
}
variable "managed_policy_arns" {
  type        = list(string)
  default     = []
  description = "Set of exclusive IAM managed policy ARNs to attach to the IAM role. If this attribute is not configured, Terraform will ignore policy attachments to this resource."
}
