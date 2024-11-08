# data "aws_eks_addon_version" "eks_pia" {
#   addon_name         = "aws-ebs-csi-driver"
#   kubernetes_version = var.cluster_version
#   most_recent        = true
# }

locals {
  addon_eks_pia = {
    # addon_version               = data.aws_eks_addon_version.eks_pia.version
    resolve_conflicts_on_create = "OVERWRITE"
    resolve_conflicts_on_update = "OVERWRITE"
    configuration_values = jsonencode(merge({}, var.eks_pod_identity_agent)
    )
  }
}
