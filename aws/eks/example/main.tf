/*
* # AWS EKS for Data Team in Dev Environment
* ## Naming convention
* - {owner}_{env}{3}_[{suffix}]_{resource}{2,3}
*/
locals {
  tags = {
    product             = "aws"
    environment         = "dev"
    owner               = "sre"
    cost-center         = "infrastructure"
    resource            = "eks"
    data-classification = "false"
  }
}

# Naming convention exemplified above
module "owner_env_suffix_resource" {

  source          = "../"
  cluster_name    = "owner-env-suffix-resource" # Naming convention exemplified above
  cluster_version = "1.30"
  region          = "us-east-1"
  profile         = "profile-aws"

  # If you do not inform the total number of availability zones,
  # the max_zones value from the `terraform-modules/aws/eks/network_vpc.tf` file will be considered.
  availability_zones = ["us-east-1b", "us-east-1d"]

  cluster_endpoint_public_access = true # Disable if the environment already uses a VPN

  cloudwatch_log_group_retention_in_days = 30
  cluster_enabled_log_types              = ["audit", "api", "authenticator"]

  cluster_addons_enabled = {
    vpc_cni                = true
    coredns                = true
    eks_pod_identity_agent = true
    kube_proxy             = true
    ebs_csi_driver         = true
  }
  vpc_cni = {
    # Custom networking
    # https://docs.aws.amazon.com/eks/latest/userguide/cni-custom-network.html
    # https://aws.github.io/aws-eks-best-practices/networking/custom-networking/
    # https://docs.aws.amazon.com/eks/latest/userguide/cni-increase-ip-addresses.html
    # https://github.com/aws/amazon-vpc-cni-k8s?tab=readme-ov-file
    # https://github.com/aws-samples/terraform-cni-custom-network-sample/b
    custom_networking = false # Default: false - Consider enabling this option in production
  }


  argocd_apps_enabled = {
    argocd                       = true
    argocd_app                   = true
    aws_load_balancer_controller = true
    cluster_autoscaler           = true
    kube_prometheus_stack        = true
    metrics_server               = true
    external_dns                 = true
    secrets_store_csi_driver     = true
    velero                       = true
    kyverno_policies             = true
    kyverno                      = true
  }

  argocd_app = {
    # chart_name    = "argocd-apps"
    # chart_version = "2.0.0"
    # repository    = "https://argoproj.github.io/argo-helm"
  }

  aws_route53 = {
    aws_profile = "sre-prod"
    aws_region  = "us-east-1"

    # (Optional) Register the nameservers on the main domain in another account and AWS Certificate Manager
    aws_account_prod = {
      private_zone     = false # Default: true
      parent_dns_name  = "private-domain.com"
      record_dns_names = ["subdomain.private-domain.com"]
    }

    # (Optional) It will just create a new DNS record in AWS Route 53 and AWS Certificate Manager
    aws_account_dev = {
      private_zone     = true # Default: true
      record_dns_names = ["new-domain.com"]
    }
  }


  # If the S3 Bucket already exists, enter the ARN as shown below.
  velero = {
    #   s3_backup_location = "arn:aws:s3:::bucket-name"
    valuesFile = file("${path.module}/values/velero/values.yaml")
  }
  external_dns = {
    route53_zone_arns = ["arn:aws:route53:::hostedzone/*"]
    valuesFile        = file("${path.module}/values/external-dns/values.yaml")
  }
  argocd = {
    valuesFile = file("${path.module}/values/argocd/values.yaml")
  }

  kube_prometheus_stack = {
    valuesFile = file("${path.module}/values/kube-prometheus-stack/values.yaml")
  }

  tags = local.tags

  managed_node_groups = {
    # Naming convention exemplified above
    owner_env_suffix_resource_main = {
      ami_type = "AL2023_x86_64_STANDARD"
      instance_types = [
        "t3.large",
        "m6i.large",
        "m7i.large"
      ]
      capacity_type = "SPOT"

      min_size     = 1
      max_size     = 5
      desired_size = 1

    }
  }

}
