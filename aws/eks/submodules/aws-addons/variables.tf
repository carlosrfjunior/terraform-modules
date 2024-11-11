# variable "region" {
#   type        = string
#   description = "(Required) AWS Region to provider"
# }

variable "cluster_name" {
  type        = string
  description = "(Required) Name of the EKS cluster."
}
# variable "cluster_version" {
#   type        = string
#   description = "(Required) Kubernetes <major>.<minor> version to use for the EKS cluster (i.e.: 1.30)"
# }
# variable "cluster_endpoint" {
#   type        = string
#   description = "(Required) Endpoint for your Kubernetes API server"
# }
# variable "oidc_provider_arn" {
#   type        = string
#   description = "(Required) The ARN of the OIDC Provider if `enable_irsa = true`"
# }
variable "cluster_addons" {
  default     = {}
  type        = map(any)
  description = "(Optional) Map of cluster addon configurations to enable for the cluster. Addon name can be the map keys or set with `name`."
}
variable "cluster_addons_enabled" {
  type = object({
    vpc_cni                = optional(bool, false)
    coredns                = optional(bool, false)
    eks_pod_identity_agent = optional(bool, false)
    kube_proxy             = optional(bool, false)
    ebs_csi_driver         = optional(bool, false)
    efs_csi_driver         = optional(bool, false)
  })
  default     = {}
  description = "(Optional) AWS EKS Addons: Map of predefined Addons. Allows you to `enable` and `disable` them when needed."
}

# variable "app_label_prefix" {
#   default     = "app.kubernetes.io/"
#   type        = string
#   description = "(Optional) Prefix for application labels in Kubernetes"
# }


variable "tags" {
  default     = {}
  type        = map(string)
  description = "(Optional) the tags to add to created resources"
}

################################################################################
# AWS EKS Addons Custom
################################################################################
variable "vpc_cni" {
  description = "AWS VPC CNI configuration values"
  type        = any
  default     = {}
}
variable "ebs_csi_driver" {
  description = "AWS EBS CSI Driver configuration values"
  type        = any
  default     = {}
}
variable "efs_csi_driver" {
  description = "AWS EBS CSI Driver configuration values"
  type        = any
  default     = {}
}
variable "eks_pod_identity_agent" {
  description = "AWS EKS POD Identity configuration values"
  type        = any
  default     = {}
}
variable "coredns" {
  description = "CoreDNS configuration values"
  type        = any
  default     = {}
}
variable "kube_proxy" {
  description = "Kube Proxy configuration values"
  type        = any
  default     = {}
}
