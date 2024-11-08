locals {
  kyverno_namespace = try(var.kyverno.namespace, "kyverno")

  kyverno = merge({
    name                  = "kyverno"
    additionalLabels      = {}
    additionalAnnotations = {}
    project               = "default"
    source = {
      chart          = "kyverno"
      repoURL        = "https://kyverno.github.io/kyverno/"
      targetRevision = "3.2.6"
      helm = {
        parameters = concat([{}
        ], try(var.kyverno.parameters, []))

        valuesObject = merge(
          yamldecode(file("${path.module}/values/kyverno/values.yaml")),
        yamldecode(try(var.kyverno.valuesFile, "{}")))
      }
    }
    destination = {
      server    = "https://kubernetes.default.svc"
      namespace = local.kyverno_namespace
    }

    syncPolicy = {
      automated = {
        prune    = true
        selfHeal = true
      }
      syncOptions = [
        "Validate=true",
        "CreateNamespace=true",
        "PrunePropagationPolicy=foreground",
        "PruneLast=true",
        "RespectIgnoreDifferences=false",
        "ApplyOutOfSyncOnly=true",
        "ServerSideApply=true"
      ]
    }
    info = [
      {
        name  = "url"
        value = "https://kyverno.io/"
      }
    ]

    postrender    = try(var.kyverno.postrender, [])
    set_sensitive = try(var.kyverno.set_sensitive, [])
    set           = try(var.kyverno.set, [])

  }, try(var.kyverno.values, {}))
}
