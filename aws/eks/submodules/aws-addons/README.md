# AWS EKS Addons Submodule

## Configuring the application via AWS Addon

- To add new configurations to the application via addon, use the configuration_values ​​parameter as shown in the example below.
- Typically, the parameters follow the same structure as the application's values.yaml in helm chart in HCL format.
```hcl
configuration_values = jsonencode(merge({
                          key = value
                          key = {
                            key = value
                          }
                          }, var.addon-name))
```
- [addon_aws_vpc_cni.tf](addon_aws_vpc_cni.tf) file example.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_addons"></a> [cluster\_addons](#input\_cluster\_addons) | (Optional) Map of cluster addon configurations to enable for the cluster. Addon name can be the map keys or set with `name`. | `map(any)` | `{}` | no |
| <a name="input_cluster_addons_enabled"></a> [cluster\_addons\_enabled](#input\_cluster\_addons\_enabled) | (Optional) AWS EKS Addons: Map of predefined Addons. Allows you to `enable` and `disable` them when needed. | <pre>object({<br/>    vpc_cni                = optional(bool, false)<br/>    coredns                = optional(bool, false)<br/>    eks_pod_identity_agent = optional(bool, false)<br/>    kube_proxy             = optional(bool, false)<br/>    ebs_csi_driver         = optional(bool, false)<br/>    efs_csi_driver         = optional(bool, false)<br/>  })</pre> | `{}` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | (Required) Name of the EKS cluster. | `string` | n/a | yes |
| <a name="input_coredns"></a> [coredns](#input\_coredns) | CoreDNS configuration values | `any` | `{}` | no |
| <a name="input_ebs_csi_driver"></a> [ebs\_csi\_driver](#input\_ebs\_csi\_driver) | AWS EBS CSI Driver configuration values | `any` | `{}` | no |
| <a name="input_efs_csi_driver"></a> [efs\_csi\_driver](#input\_efs\_csi\_driver) | AWS EBS CSI Driver configuration values | `any` | `{}` | no |
| <a name="input_eks_pod_identity_agent"></a> [eks\_pod\_identity\_agent](#input\_eks\_pod\_identity\_agent) | AWS EKS POD Identity configuration values | `any` | `{}` | no |
| <a name="input_kube_proxy"></a> [kube\_proxy](#input\_kube\_proxy) | Kube Proxy configuration values | `any` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) the tags to add to created resources | `map(string)` | `{}` | no |
| <a name="input_vpc_cni"></a> [vpc\_cni](#input\_vpc\_cni) | AWS VPC CNI configuration values | `any` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_addons_list"></a> [addons\_list](#output\_addons\_list) | Lists all activated Addons, both default and internally customized |
