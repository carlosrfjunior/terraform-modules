locals {
  atlantis = merge({
    name                  = try(var.atlantis.name, "atlantis")
    additionalLabels      = try(var.atlantis.additionalLabels, {})
    additionalAnnotations = try(var.atlantis.additionalAnnotations, {})
    project               = try(var.atlantis.project, "default")
    source = {
      chart          = try(var.atlantis.source.chart, "atlantis")
      repoURL        = try(var.atlantis.source.repoURL, "https://runatlantis.github.io/helm-charts")
      targetRevision = try(var.atlantis.source.targetRevision, "5.10.0")
      helm = {
        parameters = concat([], try(var.atlantis.parameters, []))
        valuesObject = merge(
          yamldecode(file("${path.module}/values/atlantis/values.yaml")),
        yamldecode(try(var.atlantis.valuesFile, "{}")))
      }
    }
    destination = {
      server    = try(var.atlantis.destination.server, "https://kubernetes.default.svc")
      name      = try(var.atlantis.destination.name, "")
      namespace = try(var.atlantis.destination.namespace, "atlantis")
    }
    syncPolicy = {
      automated = try(var.atlantis.syncPolicy.automated, {
        prune    = true
        selfHeal = true
      })
      syncOptions = try(var.atlantis.syncPolicy.syncOptions, [
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
        value = "https://github.com/runatlantis/helm-charts/tree/main/charts/atlantis"
      },
      {
        name  = "doc"
        value = "https://www.runatlantis.io/docs/deployment.html#kubernetes-helm-chart"
      }
    ], try(var.atlantis.info, []))
    postrender    = try(var.atlantis.postrender, [])
    set           = try(var.atlantis.set, [])
    set_sensitive = try(var.atlantis.set_sensitive, [])
  }, try(var.atlantis.values, {}))
}
