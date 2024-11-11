locals {
  addon_efs_csi_driver = {
    resolve_conflicts_on_create = "OVERWRITE"
    resolve_conflicts_on_update = "OVERWRITE"
    most_recent                 = true
    configuration_values = jsonencode(merge({
    }, var.efs_csi_driver))
  }
}
