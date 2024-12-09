## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.2 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >=5.60.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_tagging_disable"></a> [tagging\_disable](#module\_tagging\_disable) | ../ | n/a |
| <a name="module_tagging_prod_fail"></a> [tagging\_prod\_fail](#module\_tagging\_prod\_fail) | ../ | n/a |
| <a name="module_tagging_prod_success"></a> [tagging\_prod\_success](#module\_tagging\_prod\_success) | ../ | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_profile"></a> [aws\_profile](#input\_aws\_profile) | (Optional) AWS Profile to provider | `string` | `"default"` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | (Required) AWS region where the assets will be deployed | `string` | `"us-east-1"` | no |

## Outputs

No outputs.
