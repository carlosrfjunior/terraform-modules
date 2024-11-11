# AWS IAM Provider for Github
This module is intended for configuring the integration between AWS and Github via AWS IAM OIDC Provider.

**References:**
- https://aws.amazon.com/blogs/security/use-iam-roles-to-connect-github-actions-to-actions-in-aws/
- https://docs.github.com/en/actions/security-for-github-actions/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services

## Full example implementation
### Main
```hcl
/*
* # Example :: AWS IAM Provider for Github
* - Basic example code
*/
locals {
  tags = {
    product             = "aws"
    environment         = "env"
    owner               = "sre"
    cost-center         = "infrastructure"
    resource            = "github"
    data-classification = "false"
  }
}

module "owner-env-suffix-resource" {
  source = "../"

  region  = "us-east-1"
  profile = "carlosrfjunior-env"
  # inline_policy = jsondecode({})
  managed_policy_arns = []

  iam_access_entries_enabled = {
    ecr = false
    eks = false
  }

  cluster_arn_list = []
  ecr_name_list    = []
  namespace_list   = []

  tags = local.tags

  github = [
    {
      repo   = "company/repo1"
      branch = "main"
    },
    {
      repo   = "company/repo2"
      branch = "main"
    }
  ]

}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_client_id_list"></a> [client\_id\_list](#input\_client\_id\_list) | (Required) A list of client IDs (also known as `audiences`). | `list(string)` | <pre>[<br/>  "sts.amazonaws.com"<br/>]</pre> | no |
| <a name="input_cluster_arn_list"></a> [cluster\_arn\_list](#input\_cluster\_arn\_list) | (Optional) List of ARNs of AWS EKS Clusters | `list(string)` | `[]` | no |
| <a name="input_ecr_name_list"></a> [ecr\_name\_list](#input\_ecr\_name\_list) | (Optional) List of ARNs of AWS ECR Repository | `list(string)` | `[]` | no |
| <a name="input_github"></a> [github](#input\_github) | (Required) The GitHub organization name and the repository named and branch name. <br/>Example: `organization-name/repo-name` | <pre>list(object({<br/>    repo   = string<br/>    branch = string<br/>  }))</pre> | n/a | yes |
| <a name="input_iam_access_entries_enabled"></a> [iam\_access\_entries\_enabled](#input\_iam\_access\_entries\_enabled) | (Optional) Access entries allow IAM principals to authenticate to your cluster. Authorization to your cluster is provided by any combination of username, group names, or access policies. For more information, see [IAM access entries](https://docs.aws.amazon.com/eks/latest/userguide/access-entries.html). | <pre>object({<br/>    eks = optional(bool, false)<br/>    ecr = optional(bool, false)<br/>  })</pre> | <pre>{<br/>  "ecr": false,<br/>  "eks": false<br/>}</pre> | no |
| <a name="input_inline_policy"></a> [inline\_policy](#input\_inline\_policy) | (Optional) Configuration block defining an exclusive set of IAM inline policies associated with the IAM role. | <pre>list(object({<br/>    name   = optional(string, "")<br/>    policy = optional(any, {})<br/>  }))</pre> | `[]` | no |
| <a name="input_managed_policy_arns"></a> [managed\_policy\_arns](#input\_managed\_policy\_arns) | Set of exclusive IAM managed policy ARNs to attach to the IAM role. If this attribute is not configured, Terraform will ignore policy attachments to this resource. | `list(string)` | `[]` | no |
| <a name="input_namespace_list"></a> [namespace\_list](#input\_namespace\_list) | (Optional) List of namespace of AWS EKS Clusters | `list(string)` | `[]` | no |
| <a name="input_oidc_url"></a> [oidc\_url](#input\_oidc\_url) | (Required) The URL of the identity provider. Corresponds to the iss claim. | `string` | `"https://token.actions.githubusercontent.com"` | no |
| <a name="input_profile"></a> [profile](#input\_profile) | (Optional) AWS Profile to provider | `string` | `"default"` | no |
| <a name="input_region"></a> [region](#input\_region) | (Required) AWS region to provider | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Required) the tags to add to created resources | `map(string)` | `{}` | no |
| <a name="input_thumbprint_list"></a> [thumbprint\_list](#input\_thumbprint\_list) | (Required) A list of server certificate thumbprints for the OpenID Connect (OIDC) identity provider's server certificate(s). | `list(string)` | <pre>[<br/>  "6938fd4d98bab03faadb97b34396831e3780aea1"<br/>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_assume_role_arn"></a> [aws\_assume\_role\_arn](#output\_aws\_assume\_role\_arn) | Returns the ARN of the AWS Assume Role created for the Github Action. |
