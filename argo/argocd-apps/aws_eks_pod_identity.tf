# AWS EKS Pod Identity Association
# Ref: https://registry.terraform.io/modules/terraform-aws-modules/eks-pod-identity/aws/latest

module "cluster_autoscaler_pod_identity" {
  source = "terraform-aws-modules/eks-pod-identity/aws"

  create = var.argocd_apps_enabled.cluster_autoscaler

  name = "${var.cluster_name}-car"

  attach_cluster_autoscaler_policy = true
  cluster_autoscaler_cluster_names = [var.cluster_name]

  # Pod Identity Associations
  association_defaults = {
    namespace       = local.cluster_autoscaler_namespace
    service_account = local.cluster_autoscaler_service_account
  }

  associations = {
    default = {
      cluster_name = var.cluster_name
    }
  }

  tags = var.tags

}

module "aws_lb_controller_pod_identity" {
  source = "terraform-aws-modules/eks-pod-identity/aws"

  create = var.argocd_apps_enabled.aws_load_balancer_controller

  name = "${var.cluster_name}-lbc"

  attach_aws_lb_controller_policy = true

  # Pod Identity Associations
  association_defaults = {
    namespace       = local.aws_lb_controller_namespace
    service_account = local.aws_lb_controller_service_account
  }

  associations = {
    default = {
      cluster_name = var.cluster_name
    }
  }

  tags = var.tags
}

module "external_dns_pod_identity" {
  source = "terraform-aws-modules/eks-pod-identity/aws"

  create = var.argocd_apps_enabled.external_dns

  name = "${var.cluster_name}-eds"

  attach_external_dns_policy    = true
  external_dns_hosted_zone_arns = concat(try(var.external_dns.route53_zone_arns, []), try(var.aws_route53_zone_arns, []))

  # Pod Identity Associations
  association_defaults = {
    namespace       = local.external_dns_namespace
    service_account = local.external_dns_service_account
  }

  associations = {
    default = {
      cluster_name = var.cluster_name
    }
  }

  tags = var.tags

}

module "velero_pod_identity" {

  source = "terraform-aws-modules/eks-pod-identity/aws"

  create = var.argocd_apps_enabled.velero

  name = "${var.cluster_name}-vlo"

  attach_velero_policy       = true
  velero_s3_bucket_arns      = [local.velero_backup_s3_bucket_arn]
  velero_s3_bucket_path_arns = [format("%s/*", local.velero_backup_s3_bucket_arn)]

  # Pod Identity Associations
  association_defaults = {
    namespace       = local.velero_namespace
    service_account = local.velero_service_account
  }

  associations = {
    default = {
      cluster_name = var.cluster_name
    }
  }

  tags = var.tags

}
