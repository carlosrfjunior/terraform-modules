variable "vpc_cidr" {
  description = "(Optional) The IPv4 CIDR block for the VPC. CIDR can be explicitly set or it can be derived from IPAM using `ipv4_netmask_length` & `ipv4_ipam_pool_id`."
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_secondary_cidr_blocks" {
  description = "(Optional) The IPv4 CIDR block for the VPC. CIDR can be explicitly set or it can be derived from IPAM using `ipv4_netmask_length` & `ipv4_ipam_pool_id`."
  type        = list(string)
  default     = ["100.64.0.0/16"]
}

variable "create_database_subnets" {
  description = "(Optional) Create the database subnets."
  type        = bool
  default     = false
}

variable "availability_zones" {
  type        = list(string)
  description = "(Optional) If configured, the module will create the subnets according to the list provided. Otherwise, it will follow the standard flow, creating them in the first 3 zones."
  default     = []
  validation {
    condition     = try(var.availability_zones, null) == null ? false : true
    error_message = "The availability_zones variable cannot be null!"
  }
}
variable "region" {
  type        = string
  description = "(Required) AWS region to provider"
}
variable "profile" {
  type        = string
  description = "(Optional) AWS Profile to provider"
  default     = "default"
}
variable "aws_route53" {
  description = "(Optional) Configure an existing DNS or create a new one in AWS Route53"
  type        = any
  default     = {}
}

variable "create" {
  type        = bool
  description = "(Optional) Indicates to the module that it is creating a new cluster. This option should only be used to create the new EKS cluster as soon as it is created `disable.`"
  default     = true
}

variable "cluster_name" {
  type        = string
  description = "(Required) Name of the EKS cluster."
}

variable "cluster_version" {
  type        = string
  description = "(Required) Kubernetes `<major>.<minor>` version to use for the EKS cluster (i.e.: `1.30`)"
}

variable "cluster_addons" {
  default     = {}
  type        = map(any)
  description = "(Optional) Map of cluster addon configurations to enable for the cluster. Addon name can be the map keys or set with `name`."
}

variable "cluster_endpoint_public_access" {
  type        = bool
  description = "(Optional) Indicates whether or not the Amazon EKS public API server endpoint is `enabled`"
  default     = false
}
variable "access_entries" {
  type        = any
  description = "Map of access entries to add to the cluster"
  default     = {}
}
variable "vpc_peering_list" {
  type        = any
  description = "List of VPCs Peering Connections"
  default     = []
}
variable "cluster_enabled_log_types" {
  type        = list(string)
  description = "(Optional) A list of the desired control plane logs to `enable`. For more information, see Amazon EKS Control Plane Logging documentation `(https://docs.aws.amazon.com/eks/latest/userguide/control-plane-logs.html)`"
  default     = ["audit", "api", "authenticator", "controllerManager", "scheduler"]
}
variable "cloudwatch_log_group_retention_in_days" {
  type        = number
  description = "(Optional) Number of days to retain log events. Default retention - `30 days.`"
  default     = 30
}
variable "cloudwatch_log_group_class" {
  type        = string
  description = "(Optional) Specified the log class of the log group. Possible values are: `STANDARD` or `INFREQUENT_ACCESS`"
  default     = null
}
variable "cluster_addons_enabled" {
  type = object({
    vpc_cni                = optional(bool, true)
    coredns                = optional(bool, true)
    eks_pod_identity_agent = optional(bool, true)
    kube_proxy             = optional(bool, true)
    ebs_csi_driver         = optional(bool, true)
    efs_csi_driver         = optional(bool, true)
  })
  default = {
    vpc_cni                = true
    coredns                = true
    eks_pod_identity_agent = true
    kube_proxy             = true
    ebs_csi_driver         = true
    efs_csi_driver         = true
  }
  description = "(Optional) AWS EKS Addons: Map of predefined Addons. Allows you to `enable` and `disable` them when needed."
}

variable "argocd_apps_enabled" {
  type = object({
    aws_load_balancer_controller = optional(bool, true)
    nginx_ingress_external       = optional(bool, true)
    nginx_ingress_internal       = optional(bool, true)
    cluster_autoscaler           = optional(bool, true)
    kube_prometheus_stack        = optional(bool, true)
    metrics_server               = optional(bool, true)
    external_dns                 = optional(bool, true)
    argocd                       = optional(bool, true)
    argocd_app                   = optional(bool, true)
    argo_rollouts                = optional(bool, true)
    secrets_store_csi_driver     = optional(bool, true)
    velero                       = optional(bool, true)
    kyverno_policies             = optional(bool, true)
    kyverno                      = optional(bool, true)
    atlantis                     = optional(bool, true)
  })
  default = {
    aws_load_balancer_controller = true
    nginx_ingress_external       = true
    nginx_ingress_internal       = true
    cluster_autoscaler           = true
    kube_prometheus_stack        = true
    metrics_server               = true
    external_dns                 = true
    argocd                       = true
    argocd_app                   = true
    argo_rollouts                = true
    secrets_store_csi_driver     = true
    velero                       = true
    kyverno_policies             = true
    kyverno                      = true
    atlantis                     = true
  }
  description = "(Optional) ArgoCD Applications: Map of predefined Addons. Allows you to `enable` and `disable` them when needed."
}

variable "managed_node_groups" {
  default     = {}
  type        = map(any)
  description = "(Optional) Map of EKS managed node group definitions to create."
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

################################################################################
# ArgoCD Applications Custom
################################################################################
variable "install_apps" {
  default     = true
  type        = bool
  description = "(Optional) Install the ArgoCD Applications."
}
variable "aws_route53_zone_arns" {
  type        = list(string)
  description = "(Optional) The Amazon Resource Name (ARN) of the Hosted Zone."
  default     = []
}

variable "external_dns" {
  description = "external-dns configuration values"
  type        = any
  default = {
    # route53_zone_arns = ["arn:aws:route53:::hostedzone/*"]
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

variable "atlantis" {
  description = "Atlantis configuration values, Ref: `https://www.runatlantis.io/docs/deployment.html#kubernetes-helm-chart`"
  type        = any
  default     = {}
}
variable "external_secrets" {
  description = "External Secrets configuration values, Ref: `https://external-secrets.io/latest/introduction/getting-started/`"
  type        = any
  default     = {}
}
