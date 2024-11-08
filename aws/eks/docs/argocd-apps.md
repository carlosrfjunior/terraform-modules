<p align="center">
<a href="https://github.com/carlosrfjunior/helm-charts">
<image src="../assets/hotmart-logo.png" style="width: 300px;">
</a>
</p>

# ArgoCD

Some applications have been incorporated into the installation to facilitate management and centralize cluster management. This means that all applications are installed and configured via ArgoCD.

### Prerequisite:
```hcl
argocd_apps_enabled = {
    argocd      = true
    argocd_app  = true
}
```

### Built-in applications

```hcl
argocd_apps_enabled = {
  argocd                       = true
  argocd_app                   = true
  aws_load_balancer_controller = true
  cluster_autoscaler           = true
  kube_prometheus_stack        = true
  metrics_server               = true
  external_dns                 = true
  secrets_store_csi_driver     = true
  velero                       = true
  kyverno_policies             = true
  kyverno                      = true
}
  ```
