<p align="center">
<a href="https://github.com/carlosrfjunior/helm-charts">
<image src="../assets/hotmart-logo.png" style="width: 300px;">
</a>
</p>

# AWS Add-ons

This functionality allows us to enable or disable official controllers managed by AWS.

  - The following controllers have been incorporated into the module and can be adjusted via variables.
  ```hcl
  cluster_addons_enabled = {
    vpc_cni                = true
    coredns                = true
    eks_pod_identity_agent = true
    kube_proxy             = true
    ebs_csi_driver         = true
  }
  ```
- Variables

```hcl
vpc_cni {}
ebs_csi_driver {}
eks_pod_identity_agent {}
coredns {}
kube_proxy {}
```
  - Other addons available on the AWS EKS platform can be customized and activated by the variable below.

  ```hcl
  cluster_addons = {}
  ```
