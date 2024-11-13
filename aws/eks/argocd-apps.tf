
module "argocd_apps" {

  source = "../../argo/argocd-apps"

  region  = var.region
  profile = var.profile

  cluster_name    = time_sleep.wait_for_resources.triggers.cluster_name
  cluster_version = time_sleep.wait_for_resources.triggers.cluster_version
  cluster_status  = time_sleep.wait_for_resources.triggers.cluster_status

  install_apps        = var.install_apps
  argocd_apps_enabled = var.argocd_apps_enabled
  argocd_app          = var.argocd_app
  argocd              = var.argocd

  aws_route53_zone_arns            = concat(try(values(aws_route53_zone.child)[*].arn, []), try(var.aws_route53_zone_arns, []))
  nginx_ingress_external_ssl_certs = concat(try(values(aws_acm_certificate.cert)[*].arn, []), try(var.nginx_ingress_external_ssl_certs, []))
  nginx_ingress_internal_ssl_certs = concat(try(values(aws_acm_certificate.cert)[*].arn, []), try(var.nginx_ingress_internal_ssl_certs, []))

  atlantis                              = var.atlantis
  velero                                = var.velero
  kyverno                               = var.kyverno
  kyverno_policies                      = var.kyverno_policies
  external_dns                          = var.external_dns
  metrics_server                        = var.metrics_server
  cluster_autoscaler                    = var.cluster_autoscaler
  kube_prometheus_stack                 = var.kube_prometheus_stack
  external_secrets                      = var.external_secrets
  secrets_store_csi_driver              = var.secrets_store_csi_driver
  nginx_ingress_external                = var.nginx_ingress_external
  nginx_ingress_internal                = var.nginx_ingress_internal
  aws_load_balancer_controller          = var.aws_load_balancer_controller
  secrets_store_csi_driver_provider_aws = var.secrets_store_csi_driver_provider_aws

  tags = module.tagging.tags

}
