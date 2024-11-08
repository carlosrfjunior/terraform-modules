# data "aws_eks_addon_version" "ebs_csi" {
#   addon_name         = "aws-ebs-csi-driver"
#   kubernetes_version = var.cluster_version
#   most_recent        = true
# }


locals {
  addon_ebs_csi_driver = {
    # addon_version               = data.aws_eks_addon_version.ebs_csi.version
    resolve_conflicts_on_create = "OVERWRITE"
    resolve_conflicts_on_update = "OVERWRITE"
    most_recent                 = true
    configuration_values = jsonencode(merge({
      defaultStorageClass = {
        enabled = true
      }
      # storageClasses = [
      #   {
      #     name = "ebs-gp3"
      #     annotations = {
      #       "storageclass.kubernetes.io/is-default-class" = "true"
      #     }
      #     labels = {
      #       "app.kubernetes.io/cluster-name" = var.cluster_name
      #     }
      #     volumeBindingMode = "WaitForFirstConsumer"
      #     reclaimPolicy     = "Retain"
      #     parameters = {
      #       encrypted = "true"
      #     }
      #   }
      # ]
    }, var.ebs_csi_driver))
  }
}
