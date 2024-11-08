locals {
  secrets_store_csi_driver_provider_aws = merge({
    name                  = "secrets-store-csi-driver-provider-aws"
    additionalLabels      = {}
    additionalAnnotations = {}
    project               = "default"
    source = {
      chart          = "secrets-store-csi-driver-provider-aws"
      repoURL        = "https://aws.github.io/secrets-store-csi-driver-provider-aws"
      targetRevision = "0.3.9"
      helm = {
        parameters = concat([], try(var.secrets_store_csi_driver_provider_aws.parameters, []))
        valuesObject = merge({},
          # yamldecode(file("${path.module}/values/service-name/values.yaml")),
        yamldecode(try(var.secrets_store_csi_driver_provider_aws.valuesFile, "{}")))
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
        value = "https://aws.github.io/secrets-store-csi-driver-provider-aws/"
      }
    ]

    postrender    = try(var.secrets_store_csi_driver_provider_aws.postrender, [])
    set           = try(var.secrets_store_csi_driver_provider_aws.set, [])
    set_sensitive = try(var.secrets_store_csi_driver_provider_aws.set_sensitive, [])
  }, try(var.secrets_store_csi_driver_provider_aws.values, {}))
}
