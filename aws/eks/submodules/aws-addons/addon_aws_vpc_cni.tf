# https://github.com/aws/eks-charts/blob/master/stable/aws-vpc-cni/values.yaml
# data "aws_eks_addon_version" "vpc_cni" {
#   addon_name         = "vpc-cni"
#   kubernetes_version = var.cluster_version
#   most_recent        = true
# }

locals {
  additional_tags = {
    ADDITIONAL_ENI_TAGS = jsonencode(var.tags)
  }
  merge_tags = { for k, v in var.vpc_cni : k => merge(v, local.additional_tags) if k == "env" }
  addon_vpc_cni = {
    # addon_version               = data.aws_eks_addon_version.vpc_cni.version
    resolve_conflicts_on_create = "OVERWRITE"
    resolve_conflicts_on_update = "OVERWRITE"
    configuration_values        = jsonencode(merge(var.vpc_cni, local.merge_tags))
  }
}
