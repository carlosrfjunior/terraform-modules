locals {
  kyverno_policies = merge({
    name                  = "kyverno-policies"
    additionalLabels      = {}
    additionalAnnotations = {}
    project               = "default"
    source = {
      chart          = "kyverno-policies"
      repoURL        = "https://kyverno.github.io/kyverno/"
      targetRevision = "3.2.5"
      helm = {
        parameters = concat([{}
        ], try(var.kyverno_policies.parameters, []))
      }
      valuesObject = merge(
        yamldecode(file("${path.module}/values/kyverno-policies/values.yaml")),
      yamldecode(try(var.kyverno_policies.valuesFile, "{}")))
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
        "PruneLast=false",
        "RespectIgnoreDifferences=false",
        "ApplyOutOfSyncOnly=true",
        "ServerSideApply=false"
      ]
    }
    info = [
      {
        name  = "url"
        value = "https://kyverno.io/"
      }
    ]

    postrender    = try(var.kyverno_policies.postrender, [])
    set_sensitive = try(var.kyverno_policies.set_sensitive, [])
    set           = try(var.kyverno_policies.set, [])

  }, try(var.kyverno_policies.values, {}))
}
