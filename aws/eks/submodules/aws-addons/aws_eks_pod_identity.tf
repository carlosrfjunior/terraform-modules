module "aws_ebs_csi_pod_identity" {
  source = "terraform-aws-modules/eks-pod-identity/aws"

  create = var.cluster_addons_enabled.ebs_csi_driver

  name = "${var.cluster_name}-ebs-csi"

  attach_aws_ebs_csi_policy = true

  # Pod Identity Associations
  association_defaults = {
    namespace       = "kube-system"
    service_account = "ebs-csi-controller-sa"
  }

  associations = {
    default = {
      cluster_name = var.cluster_name
    }
  }

  tags = var.tags

}

module "aws_efs_csi_pod_identity" {
  source = "terraform-aws-modules/eks-pod-identity/aws"

  create = var.cluster_addons_enabled.efs_csi_driver

  name = "${var.cluster_name}-efs-csi"

  attach_aws_efs_csi_policy = true

  association_defaults = {
    namespace       = "kube-system"
    service_account = "efs-csi-controller-sa"
  }

  additional_policy_arns = {
    AmazonEFSCSIDriverPolicy = "arn:aws:iam::aws:policy/service-role/AmazonEFSCSIDriverPolicy"
  }

  associations = {
    default = {
      cluster_name = var.cluster_name
    }
  }

  tags = var.tags
}
