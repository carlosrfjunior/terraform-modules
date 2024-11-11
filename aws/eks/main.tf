/*
* # AWS EKS Module and AWS EKS Addons Submodule
*
* This module allows the installation and configuration of AWS EKS/Kubernetes and standard applications embedded via AWS EKS Add-ons and ArgoCD
*/

locals {
  cluster_autoscaler_tags = {
    "k8s.io/cluster-autoscaler/enabled"             = "true",
    "k8s.io/cluster-autoscaler/${var.cluster_name}" = "owned"
    "kubernetes.io/cluster/${var.cluster_name}"     = "owned"
  }
  # Includes Management Tags for Cluster Autoscaler only enabled `true`
  managed_node_groups = {
    for k, v in var.managed_node_groups : k => merge(v, {
      tags = { for tk, tv in local.cluster_autoscaler_tags : tk => tv if var.argocd_apps_enabled.cluster_autoscaler }
    })
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  create = var.create

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  access_entries  = var.access_entries

  # AWS EKS Addons
  cluster_addons = module.aws_addons.addons_list

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  enable_irsa = true

  # Cluster access entry
  # To add the current caller identity as an administrator
  enable_cluster_creator_admin_permissions = true

  cluster_endpoint_public_access = var.cluster_endpoint_public_access

  eks_managed_node_groups = local.managed_node_groups

  cluster_enabled_log_types              = var.cluster_enabled_log_types
  cloudwatch_log_group_class             = var.cloudwatch_log_group_class
  cloudwatch_log_group_retention_in_days = var.cloudwatch_log_group_retention_in_days



  tags = module.tagging.tags

  depends_on = [module.vpc]

}
