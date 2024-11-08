locals {
  secrets_store_csi_driver = merge({
    name                  = "secrets-store-csi-driver"
    additionalLabels      = {}
    additionalAnnotations = {}
    project               = "default"
    source = {
      chart          = "secrets-store-csi-driver"
      repoURL        = "https://kubernetes-sigs.github.io/secrets-store-csi-driver/charts"
      targetRevision = "1.4.4"
      helm = {
        parameters = concat([], try(var.secrets_store_csi_driver.parameters, []))
        valuesObject = merge({},
          # yamldecode(file("${path.module}/values/service-name/values.yaml")),
        yamldecode(try(var.secrets_store_csi_driver.valuesFile, "{}")))
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
        value = "https://secrets-store-csi-driver.sigs.k8s.io/"
      }
    ]

    postrender    = try(var.secrets_store_csi_driver.postrender, [])
    set           = try(var.secrets_store_csi_driver.set, [])
    set_sensitive = try(var.secrets_store_csi_driver.set_sensitive, [])
  }, try(var.secrets_store_csi_driver.values, {}))
}
