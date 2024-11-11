locals {
  cluster_autoscaler_service_account    = try(var.cluster_autoscaler.service_account_name, "cluster-autoscaler-sa")
  cluster_autoscaler_namespace          = try(var.cluster_autoscaler.namespace, "kube-system")
  cluster_autoscaler_image_tag_selected = try(local.cluster_autoscaler_image_tag[var.cluster_version], "v${var.cluster_version}.0")

  # Lookup map to pull latest cluster-autoscaler patch version given the cluster version
  cluster_autoscaler_image_tag = {
    "1.25" = "v1.25.3"
    "1.26" = "v1.26.6"
    "1.27" = "v1.27.5"
    "1.28" = "v1.28.2"
    "1.29" = "v1.29.0"
    "1.30" = "v1.30.0"
  }

  cluster_autoscaler = merge({
    name                  = "cluster-autoscaler"
    additionalLabels      = {}
    additionalAnnotations = {}
    project               = "default"
    source = {
      chart          = "cluster-autoscaler"
      repoURL        = "https://kubernetes.github.io/autoscaler"
      targetRevision = "9.37.0"
      helm = {
        parameters = concat([
          {
            name  = "fullnameOverride"
            value = "cluster-autoscaler"
          },
          {
            name  = "awsRegion"
            value = var.region
          },
          {
            name  = "autoDiscovery.clusterName"
            value = var.cluster_name
          },
          {
            name  = "image.tag"
            value = local.cluster_autoscaler_image_tag_selected
          },
          {
            name  = "rbac.serviceAccount.name"
            value = local.cluster_autoscaler_service_account
          }
        ], try(var.cluster_autoscaler.parameters, []))
        valuesObject = merge({},
          # yamldecode(file("${path.module}/values/service-name/values.yaml")),
        yamldecode(try(var.cluster_autoscaler.valuesFile, "{}")))
      }
    }
    destination = {
      server    = "https://kubernetes.default.svc"
      namespace = local.cluster_autoscaler_namespace
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
        value = "https://github.com/kubernetes/autoscaler"
      }
    ]

    postrender    = try(var.cluster_autoscaler.postrender, [])
    set_sensitive = try(var.cluster_autoscaler.set_sensitive, [])
    set           = try(var.cluster_autoscaler.set, [])

  }, try(var.cluster_autoscaler.values, {}))
}
