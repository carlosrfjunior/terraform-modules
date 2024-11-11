locals {

  external_dns_service_account = try(var.external_dns.service_account_name, "external-dns-sa")
  external_dns_namespace       = try(var.external_dns.namespace, "external-dns")
  # external_dns_route53_zone_arns_length = try(var.external_dns, null) == null ? 0 : length(try(var.external_dns.route53_zone_arns, {}))

  external_dns = merge({
    name                  = "external-dns"
    additionalLabels      = {}
    additionalAnnotations = {}
    project               = "default"
    source = {
      chart          = "external-dns"
      repoURL        = "https://kubernetes-sigs.github.io/external-dns/"
      targetRevision = "1.14.5"
      helm = {
        parameters = concat([
          {
            name  = "provider.name"
            value = "aws"
          },
          {
            name  = "logFormat"
            value = "json"
          },
          {
            name  = "txtOwnerId"
            value = var.cluster_name
          },
          {
            name  = "env[0].name"
            value = "AWS_DEFAULT_REGION"
          },
          {
            name  = "env[0].value"
            value = var.region
          },
          {
            name  = "serviceAccount.name"
            value = local.external_dns_service_account
          },
          {
            name  = "serviceMonitor.enabled"
            value = var.argocd_apps_enabled.kube_prometheus_stack ? "true" : "false"
          }
        ], try(var.external_dns.parameters, []))
        valuesObject = merge({},
          # yamldecode(file("${path.module}/values/service-name/values.yaml")),
        yamldecode(try(var.external_dns.valuesFile, "{}")))
      }
    }
    destination = {
      server    = "https://kubernetes.default.svc"
      namespace = local.external_dns_namespace
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
        "ApplyOutOfSyncOnly=true"
      ]
    }
    info = [
      {
        name  = "url"
        value = "https://kubernetes-sigs.github.io/external-dns/"
      }
    ]

    postrender    = try(var.external_dns.postrender, [])
    set           = try(var.external_dns.set, [])
    set_sensitive = try(var.external_dns.set_sensitive, [])


  }, try(var.external_dns.values, {}))
}
