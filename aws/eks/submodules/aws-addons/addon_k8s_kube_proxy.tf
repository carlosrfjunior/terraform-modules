locals {
  addon_kube_proxy = {
    resolve_conflicts_on_create = "OVERWRITE"
    resolve_conflicts_on_update = "OVERWRITE"
    most_recent                 = true
    configuration_values        = jsonencode(merge({}, var.kube_proxy))
  }
}
