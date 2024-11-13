locals {
  external_secrets = merge({
    name                  = try(var.external_secrets.name, "external-secrets")
    additionalLabels      = try(var.external_secrets.additionalLabels, {})
    additionalAnnotations = try(var.external_secrets.additionalAnnotations, {})
    project               = try(var.external_secrets.project, "default")
    source = {
      chart          = try(var.external_secrets.source.chart, "external-secrets")
      repoURL        = try(var.external_secrets.source.repoURL, "https://charts.external-secrets.io")
      targetRevision = try(var.external_secrets.source.targetRevision, "0.10.5")
      helm = {
        parameters = concat([], try(var.external_secrets.parameters, []))
        valuesObject = merge(
          yamldecode(file("${path.module}/values/external-secrets/values.yaml")),
        yamldecode(try(var.external_secrets.valuesFile, "{}")))
      }
    }
    destination = {
      server    = try(var.external_secrets.destination.server, "https://kubernetes.default.svc")
      name      = try(var.external_secrets.destination.name, "")
      namespace = try(var.external_secrets.destination.namespace, "external-secrets")
    }
    syncPolicy = {
      automated = try(var.external_secrets.syncPolicy.automated, {
        prune    = true
        selfHeal = true
      })
      syncOptions = try(var.external_secrets.syncPolicy.syncOptions, [
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
        value = "https://external-secrets.io/latest/"
      },
      {
        name  = "doc"
        value = "https://external-secrets.io/latest/introduction/getting-started/"
      }
    ], try(var.external_secrets.info, []))
    postrender    = try(var.external_secrets.postrender, [])
    set           = try(var.external_secrets.set, [])
    set_sensitive = try(var.external_secrets.set_sensitive, [])
  }, try(var.external_secrets.values, {}))
}
