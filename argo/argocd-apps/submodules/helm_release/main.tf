/*
* # Helm Release as Submodule
*
* The purpose of this submodule is to make [helm](https://helm.sh/) functionalities and resources available.
*/
locals {
  additional_labels = { for k, v in try(var.tags, {}) : format("%s%s", var.additional_labels_prefix, replace(k, "/[@:_ ]/", "-")) => replace(v, "/[@:_ ]/", "_") }
}

resource "helm_release" "this" {

  count = try(var.create, true) ? 1 : 0

  # provider = helm.eks

  chart                      = try(var.helm.chart, null)
  name                       = try(var.helm.name, null)
  version                    = try(var.helm.version, null)
  namespace                  = try(var.helm.namespace, null)
  repository                 = try(var.helm.repository, null)
  description                = try(var.helm.description, null)
  atomic                     = try(var.helm.atomic, null)
  cleanup_on_fail            = try(var.helm.cleanup_on_fail, null)
  create_namespace           = try(var.helm.create_namespace, null)
  dependency_update          = try(var.helm.dependency_update, null)
  devel                      = try(var.helm.devel, null)
  disable_crd_hooks          = try(var.helm.disable_crd_hooks, null)
  disable_openapi_validation = try(var.helm.disable_openapi_validation, null)
  disable_webhooks           = try(var.helm.disable_webhooks, null)
  force_update               = try(var.helm.force_update, null)
  keyring                    = try(var.helm.keyring, null)
  lint                       = try(var.helm.lint, null)
  max_history                = try(var.helm.max_history, null)
  pass_credentials           = try(var.helm.pass_credentials, null)
  recreate_pods              = try(var.helm.recreate_pods, null)
  render_subchart_notes      = try(var.helm.render_subchart_notes, null)
  replace                    = try(var.helm.replace, null)
  repository_ca_file         = try(var.helm.repository_ca_file, null)
  repository_cert_file       = try(var.helm.repository_cert_file, null)
  repository_key_file        = try(var.helm.repository_key_file, null)
  repository_password        = try(var.helm.repository_password, null)
  repository_username        = try(var.helm.repository_username, null)
  reset_values               = try(var.helm.reset_values, null)
  reuse_values               = try(var.helm.reuse_values, null)
  skip_crds                  = try(var.helm.skip_crds, null)
  timeout                    = try(var.helm.timeout, null)
  upgrade_install            = try(var.helm.upgrade_install, null)
  verify                     = try(var.helm.verify, null)
  wait                       = try(var.helm.wait, null)
  wait_for_jobs              = try(var.helm.wait_for_jobs, null)
  values                     = try(var.helm.values, null)

  dynamic "postrender" {
    for_each = length(var.helm.postrender) > 0 ? [var.helm.postrender] : []
    content {
      binary_path = postrender.value.binary_path
      args        = try(postrender.value.args, null)
    }
  }

  # Additional Labels
  dynamic "set" {
    for_each = try(var.additional_label_name, null) == null ? {} : local.additional_labels
    iterator = item
    content {
      name  = format("%s.%s", var.additional_label_name, replace(item.key, ".", "\\."))
      value = item.value
      type  = "string"
    }
  }

  dynamic "set" {
    for_each = var.helm.set
    content {
      name  = set.value.name
      value = set.value.value
      type  = try(set.value.type, null)
    }
  }

  dynamic "set_list" {
    for_each = var.helm.set_list
    content {
      name  = set_list.value.name
      value = set_list.value.value
    }
  }

  dynamic "set_sensitive" {
    for_each = var.helm.set_sensitive
    content {
      name  = set_sensitive.value.name
      value = set_sensitive.value.value
      type  = try(set_sensitive.value.type, null)
    }
  }

}
