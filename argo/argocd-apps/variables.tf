variable "region" {
  type        = string
  description = "(Required) AWS Region to provider"
}
variable "profile" {
  type        = string
  description = "(Optional) AWS Profile to provider"
  default     = "default"
}

variable "cluster_name" {
  type        = string
  description = "(Required) Name of the EKS cluster."
}
variable "cluster_version" {
  type        = string
  description = "(Required) Kubernetes <major>.<minor> version to use for the EKS cluster (i.e.: 1.30)"
}
# variable "cluster_endpoint" {
#   type        = string
#   description = "(Required) Endpoint for your Kubernetes API server"
# }
variable "cluster_status" {
  type        = string
  description = "(Optional) The status of the EKS cluster."
  default     = "ACTIVE"
}
# variable "oidc_provider_arn" {
#   type        = string
#   description = "(Required) The ARN of the OIDC Provider if `enable_irsa = true`"
# }
variable "argocd_apps_enabled" {
  type = object({
    aws_load_balancer_controller = optional(bool, false)
    nginx_ingress_external       = optional(bool, false)
    nginx_ingress_internal       = optional(bool, false)
    cluster_autoscaler           = optional(bool, false)
    kube_prometheus_stack        = optional(bool, false)
    metrics_server               = optional(bool, false)
    external_dns                 = optional(bool, false)
    argocd                       = optional(bool, false)
    argocd_app                   = optional(bool, false)
    argo_rollouts                = optional(bool, false)
    external_secrets             = optional(bool, false)
    secrets_store_csi_driver     = optional(bool, false)
    velero                       = optional(bool, false)
    kyverno                      = optional(bool, false)
    kyverno_policies             = optional(bool, false)
  })
  default     = {}
  description = "(Optional) ArgoCD Applications: Map of predefined Addons. Allows you to `enable` and `disable` them when needed."
}

variable "app_label_prefix" {
  default     = "app.kubernetes.io/"
  type        = string
  description = "(Optional) Prefix for application labels in Kubernetes"
}

variable "tags" {
  default     = {}
  type        = map(string)
  description = "(Optional) the tags to add to created resources"
}

################################################################################
# ArgoCD Applications Custom
################################################################################
variable "add_apps" {
  default     = {}
  type        = map(any)
  description = "(Optional) Add new applications that are present in the enabled list."
}
variable "aws_route53_zone_arns" {
  type        = list(string)
  description = "(Optional) The Amazon Resource Name (ARN) of the Hosted Zone."
  default     = []
}

variable "nginx_ingress_external_ssl_certs" {
  type        = list(string)
  description = "(Optional) NGINX Ingress SSL Certifications ARN."
  default     = []
}

variable "nginx_ingress_internal_ssl_certs" {
  type        = list(string)
  description = "(Optional) NGINX Ingress SSL Certifications ARN."
  default     = []
}


variable "external_dns" {
  description = "external-dns configuration values"
  type        = any
  default = {
    # route53_zone_arns = ["arn:aws:route53:::hostedzone/*"]
  }

  validation {
    condition     = var.argocd_apps_enabled.external_dns == false ? true : length(try(var.external_dns.route53_zone_arns, [])) > 0 || length(var.aws_route53_zone_arns) > 0
    error_message = "Please provide at least one AWS Route53 Zone ARN."
  }
}

variable "velero" {
  description = "Velero configuration values"
  type        = any
  default     = {}
}

variable "argocd" {
  description = "ArgoCD Server configuration values"
  type        = any
  default     = {}
}

variable "argocd_app" {
  description = "ArgoCD Application configuration values"
  type        = any
  default     = {}
}

variable "aws_load_balancer_controller" {
  description = "AWS Load Balancer Controller configuration values"
  type        = any
  default     = {}
}

variable "nginx_ingress_external" {
  description = "NGINX Ingress (External) Controller configuration values"
  type        = any
  default     = {}
}

variable "nginx_ingress_internal" {
  description = "NGINX Ingress (Internal) Controller configuration values"
  type        = any
  default     = {}
}

variable "cluster_autoscaler" {
  description = "Cluster Autoscaler configuration values"
  type        = any
  default     = {}
}

variable "kube_prometheus_stack" {
  description = "Kube Prometheus Stack configuration values"
  type        = any
  default     = {}
}

variable "metrics_server" {
  description = "Metrics Server configuration values"
  type        = any
  default     = {}
}

variable "secrets_store_csi_driver" {
  description = "Secrets Store CSI Driver configuration values"
  type        = any
  default     = {}
}
variable "secrets_store_csi_driver_provider_aws" {
  description = "Secrets Store CSI Driver for Provider AWS configuration values"
  type        = any
  default     = {}
}

variable "kyverno" {
  description = "Kyverno configuration values, Ref: `https://kyverno.io/`"
  type        = any
  default     = {}
}

variable "kyverno_policies" {
  description = "Kyverno configuration values, Ref: `https://kyverno.io/policies/pod-security`"
  type        = any
  default     = {}
}
