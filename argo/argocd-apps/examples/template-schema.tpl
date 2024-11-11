locals {
  app_name = merge({
    name                  = try(var.app_name.name, "app-name")
    additionalLabels      = try(var.app_name.additionalLabels, {})
    additionalAnnotations = try(var.app_name.additionalAnnotations, {})
    project               = try(var.app_name.project, "default")
    source = {
      chart          = try(var.app_name.source.chart, "app-name")
      repoURL        = try(var.app_name.source.repoURL, "https://reporitory-url")
      targetRevision = try(var.app_name.source.targetRevision, "latest")
      helm = {
        parameters = concat([], try(var.app_name.parameters, []))
        values = yamlencode(merge({},
          yamldecode(file("${path.module}/values/app-name/values.yaml")),
          yamldecode(try(var.app_name.valuesFile, "{}"))
        ))
        # ArgoCD - Supported from version 2.8
        #   valuesObject = merge(
        #     yamldecode(file("${path.module}/values/app-name/values.yaml")),
        #   yamldecode(try(var.app_name.valuesFile, "{}")))
      }
    }
    destination = {
      server    = try(var.app_name.destination.server, "https://kubernetes.default.svc")
      name      = try(var.app_name.destination.name, "")
      namespace = try(var.app_name.destination.namespace, "app-name")
    }
    syncPolicy = {
      automated = try(var.app_name.syncPolicy.automated, {
        prune    = true
        selfHeal = true
      })
      syncOptions = try(var.app_name.syncPolicy.syncOptions, [
        "Validate=true",
        "CreateNamespace=true",
        "PrunePropagationPolicy=foreground",
        "PruneLast=true",
        "RespectIgnoreDifferences=false",
        "ApplyOutOfSyncOnly=true"
      ])
    }
    info = concat([
      {
        name  = "url"
        value = "https://reporitory-url"
      }
    ], try(var.app_name.info, []))
    postrender     = try(var.app_name.postrender, [])
    set            = try(var.app_name.set, [])
    set_sensitive  = try(var.app_name.set_sensitive, [])
  }, try(var.app_name.values, {}))
}
