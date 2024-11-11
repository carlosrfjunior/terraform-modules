locals {
  velero_bucket_create_check = try(var.velero.s3_backup_location, null) == null ? true : false
  velero_bucket_create       = local.velero_bucket_create_check && var.argocd_apps_enabled.velero ? true : false
  velero_service_account     = try(var.velero.service_account_name, "velero-server")
  velero_namespace           = try(var.velero.namespace, "velero")
  # Bucket filter
  velero_backup_s3_bucket        = try(split(":", var.velero.s3_backup_location), split(":", module.aws_s3_bucket[0].s3_bucket_arn), "")
  velero_backup_s3_bucket_arn    = try(split("/", var.velero.s3_backup_location)[0], var.velero.s3_backup_location, module.aws_s3_bucket[0].s3_bucket_arn, null)
  velero_backup_s3_bucket_name   = try(split("/", local.velero_backup_s3_bucket[5])[0], local.velero_backup_s3_bucket[5], "sre-velero-backup")
  velero_backup_s3_bucket_prefix = try(split("/", var.velero.s3_backup_location)[1], split("/", module.aws_s3_bucket[0].s3_bucket_arn)[1], "")

  velero = merge({
    name                  = "velero"
    additionalLabels      = {}
    additionalAnnotations = {}
    project               = "default"
    source = {
      chart          = "velero"
      repoURL        = "https://vmware-tanzu.github.io/helm-charts"
      targetRevision = "7.1.4"
      helm = {
        parameters = concat([
          {
            name  = "serviceAccount.server.name"
            value = local.velero_service_account
          },
          {
            name  = "configuration.backupStorageLocation[0].provider"
            value = "aws"
          },
          {
            name  = "configuration.backupStorageLocation[0].prefix"
            value = local.velero_backup_s3_bucket_prefix
          },
          {
            name  = "configuration.backupStorageLocation[0].bucket"
            value = local.velero_backup_s3_bucket_name
          },
          {
            name  = "configuration.backupStorageLocation[0].config.region"
            value = var.region
          },
          {
            name  = "configuration.volumeSnapshotLocation[0].config.region"
            value = var.region
          },
          {
            name  = "configuration.volumeSnapshotLocation[0].provider"
            value = "aws"
          },
        ], try(var.velero.parameters, []))
        valuesObject = merge(
          yamldecode(file("${path.module}/values/velero/values.yaml")),
        yamldecode(try(var.velero.valuesFile, "{}")))
      }
    }

    destination = {
      server    = "https://kubernetes.default.svc"
      namespace = local.velero_namespace
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
        value = "https://velero.io/"
      }
    ]

    postrender    = try(var.velero.postrender, [])
    set_sensitive = try(var.velero.set_sensitive, [])
    set           = try(var.velero.set, [])

  }, try(var.velero.values, {}))
}
