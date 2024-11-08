
# AWS EKS Module and AWS EKS Addons Submodule

This module allows the installation and configuration of AWS EKS/Kubernetes and standard applications embedded via AWS EKS Add-ons and ArgoCD

> [!TIP]
> At the end of this file you can see a basic example of how to use the module.

## Documentations:
- [Custom Networking](./docs/custom-networking.md)
- [AWS EKS Add-ons](./docs/aws-eks-addons.md)
- [ArgoCD Applications](./docs/argocd-apps.md)


## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.62.0 |
| <a name="provider_aws.route53"></a> [aws.route53](#provider\_aws.route53) | 5.62.0 |
| <a name="provider_time"></a> [time](#provider\_time) | 0.12.0 |
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.2 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.61 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | 2.15.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | 2.31.0 |
## Resources

| Name | Type |
|------|------|
| [aws_acm_certificate.cert](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_iam_policy.eks_pod_identity_agent](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.eks_cluster_node_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.eks_pod_identity_agent](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_nat_gateway.private_nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_route.intra_subnets_default_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route53_record.cert_record](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.child_ns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_zone.child](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone) | resource |
| [aws_vpc_peering_connection.vpc_peering](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_peering_connection) | resource |
| [time_sleep.eks_status](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_eks_cluster.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster) | data source |
| [aws_eks_cluster_auth.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster_auth) | data source |
| [aws_iam_policy_document.eks_pod_identity_agent](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_route53_zone.parent](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |
| [aws_subnet.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_entries"></a> [access\_entries](#input\_access\_entries) | Map of access entries to add to the cluster | `any` | `{}` | no |
| <a name="input_argocd"></a> [argocd](#input\_argocd) | ArgoCD Server configuration values | `any` | `{}` | no |
| <a name="input_argocd_app"></a> [argocd\_app](#input\_argocd\_app) | ArgoCD Application configuration values | `any` | `{}` | no |
| <a name="input_argocd_apps_enabled"></a> [argocd\_apps\_enabled](#input\_argocd\_apps\_enabled) | (Optional) ArgoCD Applications: Map of predefined Addons. Allows you to `enable` and `disable` them when needed. | <pre>object({<br/>    aws_load_balancer_controller = optional(bool, true)<br/>    nginx_ingress_external       = optional(bool, true)<br/>    nginx_ingress_internal       = optional(bool, true)<br/>    cluster_autoscaler           = optional(bool, true)<br/>    kube_prometheus_stack        = optional(bool, true)<br/>    metrics_server               = optional(bool, true)<br/>    external_dns                 = optional(bool, true)<br/>    argocd                       = optional(bool, true)<br/>    argocd_app                   = optional(bool, true)<br/>    argo_rollouts                = optional(bool, true)<br/>    prefect_server               = optional(bool, false)<br/>    prefect_worker               = optional(bool, false)<br/>    prefect_exporter             = optional(bool, false)<br/>    external_secrets             = optional(bool, false)<br/>    secrets_store_csi_driver     = optional(bool, true)<br/>    velero                       = optional(bool, true)<br/>    kyverno_policies             = optional(bool, true)<br/>    kyverno                      = optional(bool, true)<br/>  })</pre> | <pre>{<br/>  "argo_rollouts": true,<br/>  "argocd": true,<br/>  "argocd_app": true,<br/>  "aws_load_balancer_controller": true,<br/>  "cluster_autoscaler": true,<br/>  "external_dns": true,<br/>  "external_secrets": false,<br/>  "kube_prometheus_stack": true,<br/>  "kyverno": true,<br/>  "kyverno_policies": true,<br/>  "metrics_server": true,<br/>  "nginx_ingress_external": true,<br/>  "nginx_ingress_internal": true,<br/>  "prefect_exporter": true,<br/>  "prefect_server": false,<br/>  "prefect_worker": false,<br/>  "secrets_store_csi_driver": true,<br/>  "velero": true<br/>}</pre> | no |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | (Optional) If configured, the module will create the subnets according to the list provided. Otherwise, it will follow the standard flow, creating them in the first 3 zones. | `list` | `[]` | no |
| <a name="input_aws_load_balancer_controller"></a> [aws\_load\_balancer\_controller](#input\_aws\_load\_balancer\_controller) | AWS Load Balancer Controller configuration values | `any` | `{}` | no |
| <a name="input_aws_route53"></a> [aws\_route53](#input\_aws\_route53) | (Optional) Configure an existing DNS or create a new one in AWS Route53 | `any` | `{}` | no |
| <a name="input_aws_route53_zone_arns"></a> [aws\_route53\_zone\_arns](#input\_aws\_route53\_zone\_arns) | (Optional) The Amazon Resource Name (ARN) of the Hosted Zone. | `list` | `[]` | no |
| <a name="input_cloudwatch_log_group_class"></a> [cloudwatch\_log\_group\_class](#input\_cloudwatch\_log\_group\_class) | (Optional) Specified the log class of the log group. Possible values are: `STANDARD` or `INFREQUENT_ACCESS` | `string` | `null` | no |
| <a name="input_cloudwatch_log_group_retention_in_days"></a> [cloudwatch\_log\_group\_retention\_in\_days](#input\_cloudwatch\_log\_group\_retention\_in\_days) | (Optional) Number of days to retain log events. Default retention - `30 days.` | `number` | `30` | no |
| <a name="input_cluster_addons"></a> [cluster\_addons](#input\_cluster\_addons) | (Optional) Map of cluster addon configurations to enable for the cluster. Addon name can be the map keys or set with `name`. | `map(any)` | `{}` | no |
| <a name="input_cluster_addons_enabled"></a> [cluster\_addons\_enabled](#input\_cluster\_addons\_enabled) | (Optional) AWS EKS Addons: Map of predefined Addons. Allows you to `enable` and `disable` them when needed. | <pre>object({<br/>    vpc_cni                = optional(bool, true)<br/>    coredns                = optional(bool, true)<br/>    eks_pod_identity_agent = optional(bool, true)<br/>    kube_proxy             = optional(bool, true)<br/>    ebs_csi_driver         = optional(bool, true)<br/>    efs_csi_driver         = optional(bool, true)<br/>  })</pre> | <pre>{<br/>  "coredns": true,<br/>  "ebs_csi_driver": true,<br/>  "efs_csi_driver": true,<br/>  "eks_pod_identity_agent": true,<br/>  "kube_proxy": true,<br/>  "vpc_cni": true<br/>}</pre> | no |
| <a name="input_cluster_autoscaler"></a> [cluster\_autoscaler](#input\_cluster\_autoscaler) | Cluster Autoscaler configuration values | `any` | `{}` | no |
| <a name="input_cluster_enabled_log_types"></a> [cluster\_enabled\_log\_types](#input\_cluster\_enabled\_log\_types) | (Optional) A list of the desired control plane logs to `enable`. For more information, see Amazon EKS Control Plane Logging documentation `(https://docs.aws.amazon.com/eks/latest/userguide/control-plane-logs.html)` | `list(string)` | <pre>[<br/>  "audit",<br/>  "api",<br/>  "authenticator",<br/>  "controllerManager",<br/>  "scheduler"<br/>]</pre> | no |
| <a name="input_cluster_endpoint_public_access"></a> [cluster\_endpoint\_public\_access](#input\_cluster\_endpoint\_public\_access) | (Optional) Indicates whether or not the Amazon EKS public API server endpoint is `enabled` | `bool` | `false` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | (Required) Name of the EKS cluster. | `string` | n/a | yes |
| <a name="input_cluster_version"></a> [cluster\_version](#input\_cluster\_version) | (Required) Kubernetes `<major>.<minor>` version to use for the EKS cluster (i.e.: `1.30`) | `string` | n/a | yes |
| <a name="input_coredns"></a> [coredns](#input\_coredns) | CoreDNS configuration values | `any` | `{}` | no |
| <a name="input_create_database_subnets"></a> [create\_database\_subnets](#input\_create\_database\_subnets) | (Optional) Create the database subnets. | `bool` | `false` | no |
| <a name="input_creating_cluster"></a> [creating\_cluster](#input\_creating\_cluster) | (Optional) Indicates to the module that it is creating a new cluster. This option should only be used to create the new EKS cluster as soon as it is created `disable.` | `bool` | `false` | no |
| <a name="input_ebs_csi_driver"></a> [ebs\_csi\_driver](#input\_ebs\_csi\_driver) | AWS EBS CSI Driver configuration values | `any` | `{}` | no |
| <a name="input_efs_csi_driver"></a> [efs\_csi\_driver](#input\_efs\_csi\_driver) | AWS EBS CSI Driver configuration values | `any` | `{}` | no |
| <a name="input_eks_pod_identity_agent"></a> [eks\_pod\_identity\_agent](#input\_eks\_pod\_identity\_agent) | AWS EKS POD Identity configuration values | `any` | `{}` | no |
| <a name="input_external_dns"></a> [external\_dns](#input\_external\_dns) | external-dns configuration values | `any` | `{}` | no |
| <a name="input_kube_prometheus_stack"></a> [kube\_prometheus\_stack](#input\_kube\_prometheus\_stack) | Kube Prometheus Stack configuration values | `any` | `{}` | no |
| <a name="input_kube_proxy"></a> [kube\_proxy](#input\_kube\_proxy) | Kube Proxy configuration values | `any` | `{}` | no |
| <a name="input_kyverno"></a> [kyverno](#input\_kyverno) | Kyverno configuration values, Ref: `https://kyverno.io/` | `any` | `{}` | no |
| <a name="input_kyverno_policies"></a> [kyverno\_policies](#input\_kyverno\_policies) | Kyverno configuration values, Ref: `https://kyverno.io/policies/pod-security` | `any` | `{}` | no |
| <a name="input_managed_node_groups"></a> [managed\_node\_groups](#input\_managed\_node\_groups) | (Optional) Map of EKS managed node group definitions to create. | `map(any)` | `{}` | no |
| <a name="input_metrics_server"></a> [metrics\_server](#input\_metrics\_server) | Metrics Server configuration values | `any` | `{}` | no |
| <a name="input_nginx_ingress_external"></a> [nginx\_ingress\_external](#input\_nginx\_ingress\_external) | NGINX Ingress (External) Controller configuration values | `any` | `{}` | no |
| <a name="input_nginx_ingress_external_ssl_certs"></a> [nginx\_ingress\_external\_ssl\_certs](#input\_nginx\_ingress\_external\_ssl\_certs) | (Optional) NGINX Ingress SSL Certifications ARN. | `list` | `[]` | no |
| <a name="input_nginx_ingress_internal"></a> [nginx\_ingress\_internal](#input\_nginx\_ingress\_internal) | NGINX Ingress (Internal) Controller configuration values | `any` | `{}` | no |
| <a name="input_nginx_ingress_internal_ssl_certs"></a> [nginx\_ingress\_internal\_ssl\_certs](#input\_nginx\_ingress\_internal\_ssl\_certs) | (Optional) NGINX Ingress SSL Certifications ARN. | `list` | `[]` | no |
| <a name="input_partition"></a> [partition](#input\_partition) | (Optional) The current AWS partition in which Terraform is working. | <pre>object({<br/>    id                 = optional(string, "aws")<br/>    dns_suffix         = optional(string, "amazonaws.com")<br/>    partition          = optional(string, "aws")<br/>    reverse_dns_prefix = optional(string, "com.amazonaws")<br/>  })</pre> | <pre>{<br/>  "dns_suffix": "amazonaws.com",<br/>  "id": "aws",<br/>  "partition": "aws",<br/>  "reverse_dns_prefix": "com.amazonaws"<br/>}</pre> | no |
| <a name="input_prefect_exporter"></a> [prefect\_exporter](#input\_prefect\_exporter) | Perfect Exporter configuration values. **Ref:** `https://github.com/PrefectHQ/prefect-helm/tree/main/charts/prometheus-prefect-exporter` | `any` | `{}` | no |
| <a name="input_prefect_server"></a> [prefect\_server](#input\_prefect\_server) | Perfect Server configuration values.  **Ref:** `https://github.com/PrefectHQ/prefect-helm/tree/main/charts/prefect-server` | `any` | `{}` | no |
| <a name="input_prefect_worker"></a> [prefect\_worker](#input\_prefect\_worker) | Perfect Worker configuration values. **Ref:** `https://github.com/PrefectHQ/prefect-helm/tree/main/charts/prefect-worker` | `any` | `{}` | no |
| <a name="input_profile"></a> [profile](#input\_profile) | (Optional) AWS Profile to provider | `string` | `"default"` | no |
| <a name="input_region"></a> [region](#input\_region) | (Required) AWS region to provider | `string` | n/a | yes |
| <a name="input_secrets_store_csi_driver"></a> [secrets\_store\_csi\_driver](#input\_secrets\_store\_csi\_driver) | Secrets Store CSI Driver configuration values | `any` | `{}` | no |
| <a name="input_secrets_store_csi_driver_provider_aws"></a> [secrets\_store\_csi\_driver\_provider\_aws](#input\_secrets\_store\_csi\_driver\_provider\_aws) | Secrets Store CSI Driver for Provider AWS configuration values | `any` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) the tags to add to created resources | `map(string)` | `{}` | no |
| <a name="input_velero"></a> [velero](#input\_velero) | Velero configuration values | `any` | `{}` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | (Optional) The IPv4 CIDR block for the VPC. CIDR can be explicitly set or it can be derived from IPAM using `ipv4_netmask_length` & `ipv4_ipam_pool_id`. | `string` | `"10.0.0.0/16"` | no |
| <a name="input_vpc_cni"></a> [vpc\_cni](#input\_vpc\_cni) | AWS VPC CNI configuration values | `any` | `{}` | no |
| <a name="input_vpc_peering_list"></a> [vpc\_peering\_list](#input\_vpc\_peering\_list) | List of VPCs Peering Connections | `any` | `[]` | no |
| <a name="input_vpc_secondary_cidr_blocks"></a> [vpc\_secondary\_cidr\_blocks](#input\_vpc\_secondary\_cidr\_blocks) | (Optional) The IPv4 CIDR block for the VPC. CIDR can be explicitly set or it can be derived from IPAM using `ipv4_netmask_length` & `ipv4_ipam_pool_id`. | `list(string)` | <pre>[<br/>  "100.64.0.0/16"<br/>]</pre> | no |
## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_argocd-apps"></a> [argocd-apps](#module\_argocd-apps) | ../../argo/argocd-apps | n/a |
| <a name="module_aws-addons"></a> [aws-addons](#module\_aws-addons) | ./submodules/aws-addons | n/a |
| <a name="module_eks"></a> [eks](#module\_eks) | terraform-aws-modules/eks/aws | ~> 20.0 |
| <a name="module_tagging"></a> [tagging](#module\_tagging) | git@github.com:carlosrfjunior/terraform-modules.git//aws/tagging | main |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | ~> 5.0 |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_access_entries"></a> [access\_entries](#output\_access\_entries) | Map of access entries created and their attributes. |
| <a name="output_access_policy_associations"></a> [access\_policy\_associations](#output\_access\_policy\_associations) | Map of eks cluster access policy associations created and their attributes. |
| <a name="output_aws_acm_certificate"></a> [aws\_acm\_certificate](#output\_aws\_acm\_certificate) | AWS ACM Certificate for new Host |
| <a name="output_aws_route_53_arn"></a> [aws\_route\_53\_arn](#output\_aws\_route\_53\_arn) | The Amazon Resource Name (ARN) of the Hosted Zone. |
| <a name="output_aws_route_53_name_servers"></a> [aws\_route\_53\_name\_servers](#output\_aws\_route\_53\_name\_servers) | A list of name servers in associated (or default) delegation set. Find more about delegation sets in AWS docs. |
| <a name="output_aws_route_53_primary_name_server"></a> [aws\_route\_53\_primary\_name\_server](#output\_aws\_route\_53\_primary\_name\_server) | The Route 53 name server that created the SOA record. |
| <a name="output_aws_route_53_zone_id"></a> [aws\_route\_53\_zone\_id](#output\_aws\_route\_53\_zone\_id) | The Hosted Zone ID. This can be referenced by zone records. |
| <a name="output_cloudwatch_log_group_arn"></a> [cloudwatch\_log\_group\_arn](#output\_cloudwatch\_log\_group\_arn) | Arn of cloudwatch log group created. |
| <a name="output_cloudwatch_log_group_name"></a> [cloudwatch\_log\_group\_name](#output\_cloudwatch\_log\_group\_name) | Name of cloudwatch log group created. |
| <a name="output_cluster_addons"></a> [cluster\_addons](#output\_cluster\_addons) | Map of attribute maps for all EKS cluster addons enabled. |
| <a name="output_cluster_arn"></a> [cluster\_arn](#output\_cluster\_arn) | The Amazon Resource Name (ARN) of the cluster. |
| <a name="output_cluster_certificate_authority_data"></a> [cluster\_certificate\_authority\_data](#output\_cluster\_certificate\_authority\_data) | Base64 encoded certificate data required to communicate with the cluster. |
| <a name="output_cluster_endpoint"></a> [cluster\_endpoint](#output\_cluster\_endpoint) | Endpoint for your Kubernetes API server. |
| <a name="output_cluster_iam_role_arn"></a> [cluster\_iam\_role\_arn](#output\_cluster\_iam\_role\_arn) | IAM role ARN of the EKS cluster. |
| <a name="output_cluster_iam_role_name"></a> [cluster\_iam\_role\_name](#output\_cluster\_iam\_role\_name) | IAM role name of the EKS cluster. |
| <a name="output_cluster_iam_role_unique_id"></a> [cluster\_iam\_role\_unique\_id](#output\_cluster\_iam\_role\_unique\_id) | Stable and unique string identifying the IAM role. |
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | The ID of the EKS cluster. Note: currently a value is returned only for local EKS clusters created on Outposts. |
| <a name="output_cluster_identity_providers"></a> [cluster\_identity\_providers](#output\_cluster\_identity\_providers) | Map of attribute maps for all EKS identity providers enabled. |
| <a name="output_cluster_ip_family"></a> [cluster\_ip\_family](#output\_cluster\_ip\_family) | The IP family used by the cluster (e.g. ipv4 or ipv6). |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | The name of the EKS cluster. |
| <a name="output_cluster_oidc_issuer_url"></a> [cluster\_oidc\_issuer\_url](#output\_cluster\_oidc\_issuer\_url) | The URL on the EKS cluster for the OpenID Connect identity provider. |
| <a name="output_cluster_platform_version"></a> [cluster\_platform\_version](#output\_cluster\_platform\_version) | Platform version for the cluster. |
| <a name="output_cluster_primary_security_group_id"></a> [cluster\_primary\_security\_group\_id](#output\_cluster\_primary\_security\_group\_id) | Cluster security group that was created by Amazon EKS for the cluster. Managed node groups use this security group for control-plane-to-data-plane communication. Referred to as 'Cluster security group' in the EKS console. |
| <a name="output_cluster_security_group_arn"></a> [cluster\_security\_group\_arn](#output\_cluster\_security\_group\_arn) | Amazon Resource Name (ARN) of the cluster security group. |
| <a name="output_cluster_security_group_id"></a> [cluster\_security\_group\_id](#output\_cluster\_security\_group\_id) | ID of the cluster security group. |
| <a name="output_cluster_service_cidr"></a> [cluster\_service\_cidr](#output\_cluster\_service\_cidr) | The CIDR block where Kubernetes pod and service IP addresses are assigned from. |
| <a name="output_cluster_status"></a> [cluster\_status](#output\_cluster\_status) | Status of the EKS cluster. One of CREATING, ACTIVE, DELETING, FAILED. |
| <a name="output_cluster_tls_certificate_sha1_fingerprint"></a> [cluster\_tls\_certificate\_sha1\_fingerprint](#output\_cluster\_tls\_certificate\_sha1\_fingerprint) | The SHA1 fingerprint of the public key of the cluster's certificate. |
| <a name="output_cluster_version"></a> [cluster\_version](#output\_cluster\_version) | The Kubernetes version for the cluster. |
| <a name="output_eks_managed_node_groups"></a> [eks\_managed\_node\_groups](#output\_eks\_managed\_node\_groups) | Map of attribute maps for all EKS managed node groups created. |
| <a name="output_eks_managed_node_groups_autoscaling_group_names"></a> [eks\_managed\_node\_groups\_autoscaling\_group\_names](#output\_eks\_managed\_node\_groups\_autoscaling\_group\_names) | List of the autoscaling group names created by EKS managed node groups. |
| <a name="output_fargate_profiles"></a> [fargate\_profiles](#output\_fargate\_profiles) | Map of attribute maps for all EKS Fargate Profiles created. |
| <a name="output_kms_key_arn"></a> [kms\_key\_arn](#output\_kms\_key\_arn) | The Amazon Resource Name (ARN) of the key. |
| <a name="output_kms_key_id"></a> [kms\_key\_id](#output\_kms\_key\_id) | The globally unique identifier for the key. |
| <a name="output_kms_key_policy"></a> [kms\_key\_policy](#output\_kms\_key\_policy) | The IAM resource policy set on the key. |
| <a name="output_node_security_group_arn"></a> [node\_security\_group\_arn](#output\_node\_security\_group\_arn) | Amazon Resource Name (ARN) of the node shared security group. |
| <a name="output_node_security_group_id"></a> [node\_security\_group\_id](#output\_node\_security\_group\_id) | ID of the node shared security group. |
| <a name="output_oidc_provider"></a> [oidc\_provider](#output\_oidc\_provider) | The OpenID Connect identity provider (issuer URL without leading https://). |
| <a name="output_oidc_provider_arn"></a> [oidc\_provider\_arn](#output\_oidc\_provider\_arn) | The ARN of the OIDC Provider if enable\_irsa = true. |
| <a name="output_self_managed_node_groups"></a> [self\_managed\_node\_groups](#output\_self\_managed\_node\_groups) | Map of attribute maps for all self managed node groups created. |
| <a name="output_self_managed_node_groups_autoscaling_group_names"></a> [self\_managed\_node\_groups\_autoscaling\_group\_names](#output\_self\_managed\_node\_groups\_autoscaling\_group\_names) | List of the autoscaling group names created by self-managed node groups. |
| <a name="output_vpc_arn"></a> [vpc\_arn](#output\_vpc\_arn) | The ARN of the VPC. |
| <a name="output_vpc_cidr_block"></a> [vpc\_cidr\_block](#output\_vpc\_cidr\_block) | The CIDR block of the VPC. |
| <a name="output_vpc_database_subnet_group"></a> [vpc\_database\_subnet\_group](#output\_vpc\_database\_subnet\_group) | The ID of the database subnet group. |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The ID of the VPC. |
| <a name="output_vpc_intra_cidr_block"></a> [vpc\_intra\_cidr\_block](#output\_vpc\_intra\_cidr\_block) | The CIDR block of the intra VPC. |
| <a name="output_vpc_intra_subnets"></a> [vpc\_intra\_subnets](#output\_vpc\_intra\_subnets) | List of IDs of intra subnets. |
| <a name="output_vpc_private_subnets"></a> [vpc\_private\_subnets](#output\_vpc\_private\_subnets) | List of IDs of private subnets. |
| <a name="output_vpc_public_subnets"></a> [vpc\_public\_subnets](#output\_vpc\_public\_subnets) | List of IDs of public subnets. |
| <a name="output_vpc_secondary_cidr_blocks"></a> [vpc\_secondary\_cidr\_blocks](#output\_vpc\_secondary\_cidr\_blocks) | The secondary CIDR blocks of the VPC. |


## Full example implementation
### AWS EKS Module - Example
`Source Reference File:` [example/main.tf](example/main.tf)
```hcl
/*
* # AWS EKS for Data Team in Dev Environment
* ## Naming convention
* - {owner}-{env}{3}-[{suffix}]-{resource}{2,3}
* - data-dev-eks
*/
locals {
  tags = {
    product             = "aws"
    environment         = "dev"
    owner               = "sre"
    cost-center         = "infrastructure"
    resource            = "eks"
    data-classification = "false"
  }
}

# Naming convention exemplified above
module "owner-env-suffix-resource" {

  source          = "../"
  cluster_name    = "owner-env-suffix-resource" # Naming convention exemplified above
  cluster_version = "1.30"
  region          = "us-east-1"
  profile         = "profile-aws"

  # If you do not inform the total number of availability zones,
  # the max_zones value from the `terraform-modules/aws/eks/network_vpc.tf` file will be considered.
  availability_zones = ["us-east-1b", "us-east-1d"]

  cluster_endpoint_public_access = true # Disable if the environment already uses a VPN

  cloudwatch_log_group_retention_in_days = 30
  cluster_enabled_log_types              = ["audit", "api", "authenticator"]

  cluster_addons_enabled = {
    vpc_cni                = true
    coredns                = true
    eks_pod_identity_agent = true
    kube_proxy             = true
    ebs_csi_driver         = true
  }
  vpc_cni = {
    # Custom networking
    # https://docs.aws.amazon.com/eks/latest/userguide/cni-custom-network.html
    # https://aws.github.io/aws-eks-best-practices/networking/custom-networking/
    # https://docs.aws.amazon.com/eks/latest/userguide/cni-increase-ip-addresses.html
    # https://github.com/aws/amazon-vpc-cni-k8s?tab=readme-ov-file
    # https://github.com/aws-samples/terraform-cni-custom-network-sample/b
    custom_networking = false # Default: false - Consider enabling this option in production
  }


  argocd_apps_enabled = {
    argocd                       = true
    argocd_app                   = true
    aws_load_balancer_controller = true
    cluster_autoscaler           = true
    kube_prometheus_stack        = true
    metrics_server               = true
    external_dns                 = true
    prefect_server               = true
    prefect_worker               = true
    prefect_agent                = false
    prefect_exporter             = true
    secrets_store_csi_driver     = true
    velero                       = true
    kyverno_policies             = true
    kyverno                      = true
  }

  argocd_app = {
    # chart_name    = "argocd-apps"
    # chart_version = "2.0.0"
    # repository    = "https://argoproj.github.io/argo-helm"
  }

  aws_route53 = {
    aws_profile = "sre-prod"
    aws_region  = "us-east-1"

    # (Optional) Register the nameservers on the main domain in another account and AWS Certificate Manager
    aws_account_prod = {
      private_zone     = false # Default: true
      parent_dns_name  = "private-domain.com"
      record_dns_names = ["subdomain.private-domain.com"]
    }

    # (Optional) It will just create a new DNS record in AWS Route 53 and AWS Certificate Manager
    aws_account_dev = {
      private_zone     = true # Default: true
      record_dns_names = ["new-domain.com"]
    }
  }


  # If the S3 Bucket already exists, enter the ARN as shown below.
  velero = {
    #   s3_backup_location = "arn:aws:s3:::bucket-name"
    valuesFile = file("${path.module}/values/velero/values.yaml")
  }
  prefect_server = {
    valuesFile = file("${path.module}/values/prefect-server/values.yaml")
  }
  external_dns = {
    route53_zone_arns = ["arn:aws:route53:::hostedzone/*"]
    valuesFile        = file("${path.module}/values/external-dns/values.yaml")
  }
  argocd = {
    valuesFile = file("${path.module}/values/argocd/values.yaml")
  }

  kube_prometheus_stack = {
    valuesFile = file("${path.module}/values/kube-prometheus-stack/values.yaml")
  }

  tags = local.tags

  managed_node_groups = {
    # Naming convention exemplified above
    owner-env-suffix-resource-main = {
      ami_type = "AL2023_x86_64_STANDARD"
      instance_types = [
        "t3.large",
        "m6i.large",
        "m7i.large"
      ]
      capacity_type = "SPOT"

      min_size     = 1
      max_size     = 5
      desired_size = 1

    }
  }

}
```
