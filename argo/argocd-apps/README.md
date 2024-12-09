<p align="center">
  <a href="https://github.com/carlosrfjunior/terraform-modules">
    <image src="https://raw.githubusercontent.com/carlosrfjunior/carlosrfjunior/main/assets/gopher-iron-man-flying.png" style="width: 300px;">
  </a>
</p>

# AWS EKS ArgoCD Module

## Usage examples

<details>
  <summary><b>Add new application in the module</b></summary>

1. Create `app_<app-name>.tf` file.
2. Use the [template-schema.tf](examples/template-schema.tf) file as a template.
3. Configure AWS EKS POD Identity [aws_eks_pod_identity.tf](aws_eks_pod_identity.tf) if your application requires access to AWS resources.
  3.1. Referencies: https://registry.terraform.io/modules/terraform-aws-modules/eks-pod-identity/aws/latest
4. Add new variable input for the application in [variables.tf](variables.tf)

```hcl
variable "app_name" {
  description = "App Name configuration values"
  type        = any
  default     = {}
}
```

5. Add the application to the map for installation on [main.tf](main.tf)

```hcl
locals {
  argocd_apps_map = {
    ...
    "app-name" = var.argocd_apps_enabled.app-name ? local.app-name : null,
  }
}
```

</details>

<details>
  <summary><b>Add new application outside the module.</b></summary>

1. Create `app_<app-name>.tf` file.
2. Use the [template-schema.tf](examples/template-schema.tf) file as a template of the module.
3. Configure AWS EKS POD Identity [aws_eks_pod_identity.tf](aws_eks_pod_identity.tf) if your application requires access to AWS resources.
  3.1. Referencies: https://registry.terraform.io/modules/terraform-aws-modules/eks-pod-identity/aws/latest
4. Add new variable input for the application in [variables.tf](variables.tf)

```hcl
variable "app_name" {
  description = "App Name configuration values"
  type        = any
  default     = {}
}
```

5.

</details>

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.75.0 |
| <a name="provider_time"></a> [time](#provider\_time) | 0.12.1 |
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.2 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.61 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | 2.15.0 |
| <a name="requirement_time"></a> [time](#requirement\_time) | 0.12.1 |
## Resources

| Name | Type |
|------|------|
| [time_sleep.eks_status](https://registry.terraform.io/providers/hashicorp/time/0.12.1/docs/resources/sleep) | resource |
| [aws_eks_cluster.eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster) | data source |
| [aws_eks_cluster_auth.eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster_auth) | data source |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_add_custom_apps"></a> [add\_custom\_apps](#input\_add\_custom\_apps) | (Optional) Add new applications that are present in the enabled list."<br/>  **Example:**<br/>  add\_custom\_apps = {<br/>    "custom-app-name" = {<br/>      name                  = "app-name"<br/>      additionalLabels      = {}<br/>      additionalAnnotations = {}<br/>      ...<br/>    }<br/>  } | `map(any)` | `{}` | no |
| <a name="input_app_label_prefix"></a> [app\_label\_prefix](#input\_app\_label\_prefix) | (Optional) Prefix for application labels in Kubernetes | `string` | `"app.kubernetes.io/"` | no |
| <a name="input_argocd"></a> [argocd](#input\_argocd) | ArgoCD Server configuration values | `any` | `{}` | no |
| <a name="input_argocd_app"></a> [argocd\_app](#input\_argocd\_app) | ArgoCD Application configuration values | `any` | `{}` | no |
| <a name="input_argocd_apps_enabled"></a> [argocd\_apps\_enabled](#input\_argocd\_apps\_enabled) | (Optional) ArgoCD Applications: Map of predefined Addons. Allows you to `enable` and `disable` them when needed. | <pre>object({<br/>    aws_load_balancer_controller = optional(bool, false)<br/>    nginx_ingress_external       = optional(bool, false)<br/>    nginx_ingress_internal       = optional(bool, false)<br/>    cluster_autoscaler           = optional(bool, false)<br/>    kube_prometheus_stack        = optional(bool, false)<br/>    metrics_server               = optional(bool, false)<br/>    external_dns                 = optional(bool, false)<br/>    argocd                       = optional(bool, false)<br/>    argocd_app                   = optional(bool, false)<br/>    argo_rollouts                = optional(bool, false)<br/>    external_secrets             = optional(bool, false)<br/>    secrets_store_csi_driver     = optional(bool, false)<br/>    velero                       = optional(bool, false)<br/>    kyverno                      = optional(bool, false)<br/>    kyverno_policies             = optional(bool, false)<br/>    atlantis                     = optional(bool, false)<br/>  })</pre> | `{}` | no |
| <a name="input_atlantis"></a> [atlantis](#input\_atlantis) | Atlantis configuration values, Ref: `https://www.runatlantis.io/docs/deployment.html#kubernetes-helm-chart` | `any` | `{}` | no |
| <a name="input_aws_load_balancer_controller"></a> [aws\_load\_balancer\_controller](#input\_aws\_load\_balancer\_controller) | AWS Load Balancer Controller configuration values | `any` | `{}` | no |
| <a name="input_aws_route53_zone_arns"></a> [aws\_route53\_zone\_arns](#input\_aws\_route53\_zone\_arns) | (Optional) The Amazon Resource Name (ARN) of the Hosted Zone. | `list(string)` | `[]` | no |
| <a name="input_cluster_autoscaler"></a> [cluster\_autoscaler](#input\_cluster\_autoscaler) | Cluster Autoscaler configuration values | `any` | `{}` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | (Required) Name of the EKS cluster. | `string` | n/a | yes |
| <a name="input_cluster_status"></a> [cluster\_status](#input\_cluster\_status) | (Optional) The status of the EKS cluster. | `string` | `"ACTIVE"` | no |
| <a name="input_cluster_version"></a> [cluster\_version](#input\_cluster\_version) | (Required) Kubernetes <major>.<minor> version to use for the EKS cluster (i.e.: 1.30) | `string` | n/a | yes |
| <a name="input_external_dns"></a> [external\_dns](#input\_external\_dns) | external-dns configuration values | `any` | `{}` | no |
| <a name="input_external_secrets"></a> [external\_secrets](#input\_external\_secrets) | External Secrets configuration values, Ref: `https://external-secrets.io/latest/introduction/getting-started/` | `any` | `{}` | no |
| <a name="input_install_apps"></a> [install\_apps](#input\_install\_apps) | (Optional) Install the ArgoCD Applications. | `bool` | `true` | no |
| <a name="input_kube_prometheus_stack"></a> [kube\_prometheus\_stack](#input\_kube\_prometheus\_stack) | Kube Prometheus Stack configuration values | `any` | `{}` | no |
| <a name="input_kyverno"></a> [kyverno](#input\_kyverno) | Kyverno configuration values, Ref: `https://kyverno.io/` | `any` | `{}` | no |
| <a name="input_kyverno_policies"></a> [kyverno\_policies](#input\_kyverno\_policies) | Kyverno configuration values, Ref: `https://kyverno.io/policies/pod-security` | `any` | `{}` | no |
| <a name="input_metrics_server"></a> [metrics\_server](#input\_metrics\_server) | Metrics Server configuration values | `any` | `{}` | no |
| <a name="input_nginx_ingress_external"></a> [nginx\_ingress\_external](#input\_nginx\_ingress\_external) | NGINX Ingress (External) Controller configuration values | `any` | `{}` | no |
| <a name="input_nginx_ingress_external_ssl_certs"></a> [nginx\_ingress\_external\_ssl\_certs](#input\_nginx\_ingress\_external\_ssl\_certs) | (Optional) NGINX Ingress SSL Certifications ARN. | `list(string)` | `[]` | no |
| <a name="input_nginx_ingress_internal"></a> [nginx\_ingress\_internal](#input\_nginx\_ingress\_internal) | NGINX Ingress (Internal) Controller configuration values | `any` | `{}` | no |
| <a name="input_nginx_ingress_internal_ssl_certs"></a> [nginx\_ingress\_internal\_ssl\_certs](#input\_nginx\_ingress\_internal\_ssl\_certs) | (Optional) NGINX Ingress SSL Certifications ARN. | `list(string)` | `[]` | no |
| <a name="input_profile"></a> [profile](#input\_profile) | (Optional) AWS Profile to provider | `string` | `"default"` | no |
| <a name="input_region"></a> [region](#input\_region) | (Required) AWS Region to provider | `string` | n/a | yes |
| <a name="input_secrets_store_csi_driver"></a> [secrets\_store\_csi\_driver](#input\_secrets\_store\_csi\_driver) | Secrets Store CSI Driver configuration values | `any` | `{}` | no |
| <a name="input_secrets_store_csi_driver_provider_aws"></a> [secrets\_store\_csi\_driver\_provider\_aws](#input\_secrets\_store\_csi\_driver\_provider\_aws) | Secrets Store CSI Driver for Provider AWS configuration values | `any` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) the tags to add to created resources | `map(string)` | `{}` | no |
| <a name="input_velero"></a> [velero](#input\_velero) | Velero configuration values | `any` | `{}` | no |
## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_argocd"></a> [argocd](#module\_argocd) | ./submodules/helm_release | n/a |
| <a name="module_argocd_app"></a> [argocd\_app](#module\_argocd\_app) | ./submodules/helm_release | n/a |
| <a name="module_aws_lb_controller_pod_identity"></a> [aws\_lb\_controller\_pod\_identity](#module\_aws\_lb\_controller\_pod\_identity) | terraform-aws-modules/eks-pod-identity/aws | n/a |
| <a name="module_aws_s3_bucket"></a> [aws\_s3\_bucket](#module\_aws\_s3\_bucket) | terraform-aws-modules/s3-bucket/aws | 4.1.2 |
| <a name="module_cluster_autoscaler_pod_identity"></a> [cluster\_autoscaler\_pod\_identity](#module\_cluster\_autoscaler\_pod\_identity) | terraform-aws-modules/eks-pod-identity/aws | n/a |
| <a name="module_external_dns_pod_identity"></a> [external\_dns\_pod\_identity](#module\_external\_dns\_pod\_identity) | terraform-aws-modules/eks-pod-identity/aws | n/a |
| <a name="module_velero_pod_identity"></a> [velero\_pod\_identity](#module\_velero\_pod\_identity) | terraform-aws-modules/eks-pod-identity/aws | n/a |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_argocd_apps_enabled"></a> [argocd\_apps\_enabled](#output\_argocd\_apps\_enabled) | List all application enabled. |



## Full example implementation

### Schema template for new applications
```hcl
locals {
  app_name = merge({
    name                  = try(var.app_name.name, "app-name")
    additionalLabels      = try(var.app_name.additionalLabels, {})
    additionalAnnotations = try(var.app_name.additionalAnnotations, {})
    project               = try(var.app_name.project, "default")
    source = {
      chart          = try(var.app_name.source.chart, "app-name")
      repoURL        = try(var.app_name.source.repoURL, "https://reporitory-url")
      targetRevision = try(var.app_name.source.targetRevision, "latest")
      helm = {
        parameters = concat([], try(var.app_name.parameters, []))
        values = yamlencode(merge({},
          yamldecode(file("${path.module}/values/app-name/values.yaml")),
          yamldecode(try(var.app_name.valuesFile, "{}"))
        ))
        # ArgoCD - Supported from version 2.8
        #   valuesObject = merge(
        #     yamldecode(file("${path.module}/values/app-name/values.yaml")),
        #   yamldecode(try(var.app_name.valuesFile, "{}")))
      }
    }
    destination = {
      server    = try(var.app_name.destination.server, "https://kubernetes.default.svc")
      name      = try(var.app_name.destination.name, "")
      namespace = try(var.app_name.destination.namespace, "app-name")
    }
    syncPolicy = {
      automated = try(var.app_name.syncPolicy.automated, {
        prune    = true
        selfHeal = true
      })
      syncOptions = try(var.app_name.syncPolicy.syncOptions, [
        "Validate=true",
        "CreateNamespace=true",
        "PrunePropagationPolicy=foreground",
        "PruneLast=true",
        "RespectIgnoreDifferences=false",
        "ApplyOutOfSyncOnly=true"
      ])
    }
    info = concat([
      {
        name  = "url"
        value = "https://reporitory-url"
      }
    ], try(var.app_name.info, []))
    postrender     = try(var.app_name.postrender, [])
    set            = try(var.app_name.set, [])
    set_sensitive  = try(var.app_name.set_sensitive, [])
  }, try(var.app_name.values, {}))
}
```

### Final template file
```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: cluster-autoscaler
  namespace: argocd
spec:
  destination:
    namespace: kube-system
    server: https://kubernetes.default.svc
  info:
    - name: url
      value: https://github.com/kubernetes/autoscaler
  project: default
  source:
    chart: cluster-autoscaler
    targetRevision: 9.37.0
    helm:
      parameters:
        - name: fullnameOverride
          value: cluster-autoscaler
        - name: awsRegion
          value: us-east-1
        - name: autoDiscovery.clusterName
          value: data-dev-eks
        - name: image.tag
          value: v1.30.0
        - name: rbac.serviceAccount.name
          value: cluster-autoscaler-sa
    repoURL: https://kubernetes.github.io/autoscaler
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
    syncOptions:
      - Validate=true
      - CreateNamespace=false
      - PrunePropagationPolicy=foreground
      - PruneLast=true
      - RespectIgnoreDifferences=false
      - ApplyOutOfSyncOnly=true
```
