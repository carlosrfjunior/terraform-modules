/*
* # AWS EKS ArgoCD Module
*/

locals {
  # Add the app to the list below
  argocd_apps_map = {
    "aws_load_balancer_controller"          = var.argocd_apps_enabled.aws_load_balancer_controller ? local.aws_load_balancer_controller : null,
    "nginx_ingress_external"                = var.argocd_apps_enabled.nginx_ingress_external ? local.nginx_ingress_external : null,
    "nginx_ingress_internal"                = var.argocd_apps_enabled.nginx_ingress_internal ? local.nginx_ingress_internal : null,
    "cluster_autoscaler"                    = var.argocd_apps_enabled.cluster_autoscaler ? local.cluster_autoscaler : null,
    "kube_prometheus_stack"                 = var.argocd_apps_enabled.kube_prometheus_stack ? local.kube_prometheus_stack : null,
    "metrics_server"                        = var.argocd_apps_enabled.metrics_server ? local.metrics_server : null,
    "external_dns"                          = var.argocd_apps_enabled.external_dns ? local.external_dns : null,
    "secrets_store_csi_driver"              = var.argocd_apps_enabled.secrets_store_csi_driver ? local.secrets_store_csi_driver : null,
    "secrets_store_csi_driver_provider_aws" = var.argocd_apps_enabled.secrets_store_csi_driver ? local.secrets_store_csi_driver_provider_aws : null,
    "velero"                                = var.argocd_apps_enabled.velero ? local.velero : null,
    "kyverno_policies"                      = var.argocd_apps_enabled.kyverno_policies && var.argocd_apps_enabled.kyverno ? local.kyverno_policies : null,
    "kyverno"                               = var.argocd_apps_enabled.kyverno ? local.kyverno : null,
    "atlantis"                              = var.argocd_apps_enabled.atlantis ? local.atlantis : null,
  }
}
