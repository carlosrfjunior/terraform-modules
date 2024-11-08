# Ref: https://argo-cd.readthedocs.io/en/stable/getting_started/
# argocd admin initial-password -n argocd
# argocd login argo-cd-argocd-server.argocd.svc.cluster.local
# argocd account update-password

resource "time_sleep" "eks_status" {
  create_duration = "60s"
  triggers = {
    status = var.cluster_status
  }
}

module "argocd" {
  source = "./submodules/helm_release"

  create = var.argocd_apps_enabled.argocd

  providers = {
    helm = helm.eks
  }

  # cluster_name              = var.cluster_name
  # cluster_endpoint          = var.cluster_endpoint
  # cluster_version           = var.cluster_version
  # cluster_oidc_provider_arn = var.oidc_provider_arn

  # Ref: https://github.com/argoproj/argo-helm/blob/main/charts/argo-cd/Chart.yaml
  helm = {

    name             = try(var.argocd.name, "argo-cd")
    description      = try(var.argocd.description, " Helm chart for Argo CD, a declarative, GitOps continuous delivery tool for Kubernetes.")
    namespace        = try(var.argocd.namespace, "argocd")
    create_namespace = try(var.argocd.create_namespace, true)
    chart            = try(var.argocd.chart, "argo-cd")
    version          = try(var.argocd.version, "7.5.2")
    repository       = try(var.argocd.repository, "https://argoproj.github.io/argo-helm")
    reset_values     = try(var.argocd.reset_values, true)

    values = [
      file("${path.module}/values/argocd/values.yaml"),
      try(var.argocd.valuesFile, ""),
      yamlencode(try(var.argocd.values, {}))
    ]

    set = concat([
      {
        name  = "fullnameOverride"
        value = "argocd"
      },
    ], try(var.argocd.parameters, []))

  }

  additional_label_name = "global.additionalLabels"

  tags = var.tags

  depends_on = [time_sleep.eks_status]

}
