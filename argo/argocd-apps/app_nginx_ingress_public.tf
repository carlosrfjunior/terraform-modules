locals {

  nginx_ingress_external = merge({
    name                  = "nginx-ingress"
    additionalLabels      = {}
    additionalAnnotations = {}
    project               = "default"
    source = {
      chart          = "ingress-nginx"
      repoURL        = "https://kubernetes.github.io/ingress-nginx"
      targetRevision = "4.11.2"
      helm = {
        parameters = concat([{
          name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-ssl-cert"
          value = join(" ", try(var.nginx_ingress_external_ssl_certs, null))
        }], try(var.nginx_ingress_external.parameters, []))
        valuesObject = merge(
          yamldecode(file("${path.module}/values/nginx-ingress/values-external.yaml")),
        yamldecode(try(var.nginx_ingress_external.valuesFile, "{}")))
      }
    }
    destination = {
      server    = "https://kubernetes.default.svc"
      namespace = try(var.nginx_ingress_external.namespace, "ingress-nginx")
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
        "ApplyOutOfSyncOnly=true"
      ]
    }
    info = [
      {
        name  = "url"
        value = "https://aws.github.io/eks-charts"
      }
    ]

    postrender    = try(var.nginx_ingress_external.postrender, [])
    set_sensitive = try(var.nginx_ingress_external.set_sensitive, [])
    set           = try(var.nginx_ingress_external.set, [])

  }, try(var.nginx_ingress_external.values, {}))
}