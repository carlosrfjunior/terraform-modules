locals {

  kube_prometheus_stack = merge({
    name                  = "kube-prometheus-stack"
    additionalLabels      = {}
    additionalAnnotations = {}
    project               = "default"
    source = {
      chart          = "kube-prometheus-stack"
      repoURL        = "https://prometheus-community.github.io/helm-charts"
      targetRevision = "61.9.0"
      helm = {
        parameters = concat([
          {
            name  = "prometheus.annotations.argocd\\.argoproj\\.io/skip-health-check"
            value = "true"
            forceString : true
          }
        ], try(var.kube_prometheus_stack.parameters, []))
        valuesObject = merge({},
          # yamldecode(file("${path.module}/values/service-name/values.yaml")),
        yamldecode(try(var.kube_prometheus_stack.valuesFile, "{}")))
      }
    }
    destination = {
      server    = "https://kubernetes.default.svc"
      namespace = "kube-prometheus-stack"
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
        "RespectIgnoreDifferences=false"
      ]
    }
    info = [
      {
        name  = "url"
        value = "https://github.com/prometheus-community/helm-charts/"
      }
    ]
    postrender    = try(var.kube_prometheus_stack.postrender, [])
    set           = try(var.kube_prometheus_stack.set, [])
    set_sensitive = try(var.kube_prometheus_stack.set_sensitive, [])
  }, try(var.kube_prometheus_stack.values, {}))
}
