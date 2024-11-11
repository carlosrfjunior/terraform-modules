/*
* # AWS EKS Addons Submodule
*/

locals {
  # Map of predefined Addons. Allows you to `enable` and `disable` them when needed.
  # Ref: https://docs.aws.amazon.com/eks/latest/userguide/eks-add-ons.html
  addons_include = {
    # VPC CNI
    vpc-cni = !var.cluster_addons_enabled.vpc_cni ? null : local.addon_vpc_cni
    # CoreDNS
    coredns = !var.cluster_addons_enabled.coredns ? null : local.addon_coredns
    # AWS POD Identity Agent
    eks-pod-identity-agent = !var.cluster_addons_enabled.eks_pod_identity_agent ? null : local.addon_eks_pia
    # Kube Proxy
    kube-proxy = !var.cluster_addons_enabled.kube_proxy ? null : local.addon_kube_proxy
    # AWS EBS CSI Driver
    aws-ebs-csi-driver = !var.cluster_addons_enabled.ebs_csi_driver ? null : local.addon_ebs_csi_driver
    # AWS EBS CSI Driver
    aws-efs-csi-driver = !var.cluster_addons_enabled.efs_csi_driver ? null : local.addon_efs_csi_driver
  }
  # Remove null addons
  addons_enabled = { for k, v in local.addons_include : k => v if v != null }
}

locals {
  addons_list = merge(local.addons_enabled, var.cluster_addons)
}
