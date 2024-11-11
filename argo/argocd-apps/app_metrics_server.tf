locals {
  metrics_server = merge({
    name                  = "metrics-server"
    additionalLabels      = {}
    additionalAnnotations = {}
    project               = "default"
    source = {
      chart          = "metrics-server"
      repoURL        = "https://kubernetes-sigs.github.io/metrics-server/"
      targetRevision = "3.12.1"
      helm = {
        parameters = concat([], try(var.metrics_server.parameters, []))
        valuesObject = merge({},
          # yamldecode(file("${path.module}/values/service-name/values.yaml")),
        yamldecode(try(var.metrics_server.valuesFile, "{}")))
      }
    }
    destination = {
      server    = "https://kubernetes.default.svc"
      namespace = "kube-system"
    }
    syncPolicy = {
      automated = {
        prune    = true
        selfHeal = true
      }
      syncOptions = [
        "Validate=true",
        "CreateNamespace=false",
        "PrunePropagationPolicy=foreground",
        "PruneLast=true",
        "RespectIgnoreDifferences=false",
        "ApplyOutOfSyncOnly=true"
      ]
    }
    info = [
      {
        name  = "url"
        value = "https://kubernetes-sigs.github.io/metrics-server/"
      }
    ]

    postrender    = try(var.metrics_server.postrender, [])
    set           = try(var.metrics_server.set, [])
    set_sensitive = try(var.metrics_server.set_sensitive, [])
  }, try(var.metrics_server.values, {}))
}
