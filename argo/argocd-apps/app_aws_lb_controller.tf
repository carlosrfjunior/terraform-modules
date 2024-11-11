locals {
  aws_lb_controller_service_account = try(var.aws_load_balancer_controller.service_account_name, "aws-load-balancer-controller-sa")
  aws_lb_controller_namespace       = try(var.aws_load_balancer_controller.namespace, "kube-system")

  aws_load_balancer_controller = merge({
    name                  = "aws-load-balancer-controller"
    additionalLabels      = {}
    additionalAnnotations = {}
    project               = "default"
    source = {
      chart          = "aws-load-balancer-controller"
      repoURL        = "https://aws.github.io/eks-charts"
      targetRevision = "1.8.2"
      helm = {
        parameters = concat([
          {
            name  = "serviceAccount.name"
            value = local.aws_lb_controller_service_account
          },
          {
            name  = "clusterName"
            value = var.cluster_name
          }
        ], try(var.aws_load_balancer_controller.parameters, []))

        valuesObject = merge(
          yamldecode(file("${path.module}/values/aws-lb-controller/values.yaml")),
        yamldecode(try(var.aws_load_balancer_controller.valuesFile, "{}")))
      }
    }
    destination = {
      server    = "https://kubernetes.default.svc"
      namespace = local.aws_lb_controller_namespace
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
        value = "https://aws.github.io/eks-charts"
      }
    ]

    postrender    = try(var.aws_load_balancer_controller.postrender, [])
    set_sensitive = try(var.aws_load_balancer_controller.set_sensitive, [])
    set           = try(var.aws_load_balancer_controller.set, [])

  }, try(var.aws_load_balancer_controller.values, {}))
}
