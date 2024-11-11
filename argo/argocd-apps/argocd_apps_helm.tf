locals {
  additional_labels = { for k, v in try(var.tags, {}) : format("%s%s", var.app_label_prefix, replace(k, ":", "-")) => replace(replace(v, ":", "_"), "@", "-") }
  argocd_apps_list  = { for k, v in local.argocd_apps_map : k => v if v != null }
  add_apps_list     = { for k, v in var.add_apps : k => v if v != null }
  argocd_apps       = merge(local.argocd_apps_list, local.add_apps_list)
}

module "argocd_app" {
  for_each = local.argocd_apps

  source = "./submodules/helm_release"

  providers = {
    helm = helm.eks
  }

  # create = var.argocd_apps_enabled.argocd_app

  # activate_wait = false

  # cluster_name              = var.cluster_name
  # cluster_endpoint          = var.cluster_endpoint
  # cluster_version           = var.cluster_version
  # cluster_oidc_provider_arn = var.oidc_provider_arn


  # https://github.com/argoproj/argo-helm/blob/main/charts/argocd-apps
  # Ref: https://github.com/argoproj/argo-cd/blob/master/docs/operator-manual/
  helm = {
    name             = replace(try(each.value.name, ""), "/[@_ ]/", "-")
    description      = "A Helm chart for managing additional Argo CD Applications and Projects"
    namespace        = try(each.value.argocd, null) == null ? "argocd" : try(each.value.argocd.namespace, "argocd")
    create_namespace = try(each.value.argocd, null) == null ? true : try(each.value.argocd.create_namespace, true)
    chart            = try(var.argocd_app.chart_name, "argocd-apps")
    version          = try(var.argocd_app.version, "2.0.0")
    repository       = try(var.argocd_app.repository, "https://argoproj.github.io/argo-helm")
    values = [
      yamlencode(
        {
          applications = {
            replace(try(each.value.name, ""), "/[@_ ]/", "-") = {
              additionalLabels      = merge(try(local.additional_labels, {}), try(each.value.additionalLabels, {}))
              additionalAnnotations = try(each.value.additionalAnnotations, {})
              finalizers = concat([
                "resources-finalizer.argocd.argoproj.io"
              ], try(each.value.finalizers, []))
              project = try(each.value.project, "default")
              source  = try(each.value.source, {})
              sources = try(each.value.sources, null)
              destination = {
                server    = try(each.value.destination.server, "")
                name      = try(each.value.destination.name, "")
                namespace = try(each.value.destination.namespace, "")
              }
              ignoreDifferences = try(each.value.ignoreDifferences, [])
              syncPolicy        = try(each.value.syncPolicy, {})
              info              = try(each.value.info, [{}])
            }
          }
        }
      )
    ]

    upgrade_install            = try(each.value.upgrade_install, true)
    timeout                    = try(each.value.timeout, null)
    repository_key_file        = try(each.value.repository_key_file, null)
    repository_cert_file       = try(each.value.repository_cert_file, null)
    repository_ca_file         = try(each.value.repository_ca_file, null)
    repository_username        = try(each.value.repository_username, null)
    repository_password        = try(each.value.repository_password, null)
    devel                      = try(each.value.devel, null)
    verify                     = try(each.value.verify, null)
    keyring                    = try(each.value.keyring, null)
    disable_webhooks           = try(each.value.disable_webhooks, null)
    reuse_values               = try(each.value.reuse_values, null)
    reset_values               = try(each.value.reset_values, true)
    force_update               = try(each.value.force_update, null)
    recreate_pods              = try(each.value.recreate_pods, null)
    cleanup_on_fail            = try(each.value.cleanup_on_fail, null)
    max_history                = try(each.value.max_history, null)
    atomic                     = try(each.value.atomic, null)
    skip_crds                  = try(each.value.skip_crds, null)
    render_subchart_notes      = try(each.value.render_subchart_notes, null)
    disable_openapi_validation = try(each.value.disable_openapi_validation, null)
    wait                       = try(each.value.wait, null)
    wait_for_jobs              = try(each.value.wait_for_jobs, null)
    dependency_update          = try(each.value.dependency_update, null)
    replace                    = try(each.value.replace, null)
    lint                       = try(each.value.lint, null)

    postrender    = try(each.value.postrender, [])
    set           = try(each.value.set, [])
    set_list      = try(each.value.set_list, [])
    set_sensitive = try(each.value.set_sensitive, [])
  }

  tags = var.tags

  depends_on = [module.argocd, module.aws_s3_bucket, time_sleep.eks_status]

}
