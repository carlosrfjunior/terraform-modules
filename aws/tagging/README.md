<p align="center">
  <a href="https://github.com/carlosrfjunior/terraform-modules">
    <image src="https://avatars.githubusercontent.com/u/180111812?s=400&u=cda6d53ade890c5d47426504081e4fcb1167199d&v=4" style="width: 300px;">
  </a>
</p>

# AWS Tagging module

The tagging system allows us to refine management and implement interaction strategies for better resource management. This module allows us to define the internal tag system for the corporation and gives us the possibility of identifying the parties involved.

**References:

- https://docs.aws.amazon.com/whitepapers/latest/tagging-best-practices/tagging-best-practices.html
- https://docs.aws.amazon.com/whitepapers/latest/tagging-best-practices/building-your-tagging-strategy.html

## Full example implementation

### Variable
  ```hcl
variable "aws_region" {
  type        = string
  description = "(Required) AWS region where the assets will be deployed"
}
variable "aws_profile" {
  type        = string
  description = "(Optional) AWS Profile to provider"
  default     = "default"
}
```

### Provider
```hcl
provider "aws" {
  default_tags {
    tags = module.tagging.tags
  }
}
```

### Tagging
```hcl
module "tagging" {
  source              = "../"
  product             = "aws"
  environment         = "testing"
  owner               = "sre"
  cost_center         = "infrastructure"
  resource            = "tagging"
  data_classification = false
  profile             = var.aws_profile
  region              = var.aws_region
}
```


### Main
```hcl
module "tagging" {
  source              = "../"
  product             = "aws"
  environment         = "testing"
  owner               = "sre"
  cost_center         = "infrastructure"
  resource            = "tagging"
  data_classification = false
  profile             = var.aws_profile
  region              = var.aws_region
}
```

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.75.0 |
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.2 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >=5.60.0 |
## Resources

| Name | Type |
|------|------|
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cost_center"></a> [cost\_center](#input\_cost\_center) | (Required) Indicates the cost center associated with the resource. | `string` | n/a | yes |
| <a name="input_data_classification"></a> [data\_classification](#input\_data\_classification) | (Required) Identifies whether the resource contains, stores, or uses any type of special or sensitive data. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | (Required) Indicates the lifecycle stage for the resource. | `string` | n/a | yes |
| <a name="input_managed_by"></a> [managed\_by](#input\_managed\_by) | (Optional) The framework, tool, and/or method that created this resource. | `string` | `"terraform"` | no |
| <a name="input_owner"></a> [owner](#input\_owner) | (Required) Indicates the owner of the resource. | `string` | n/a | yes |
| <a name="input_product"></a> [product](#input\_product) | (Required) Indicates the product associated with the resource. | `string` | n/a | yes |
| <a name="input_profile"></a> [profile](#input\_profile) | (Optional) AWS Profile to provider | `string` | `"default"` | no |
| <a name="input_region"></a> [region](#input\_region) | (Required) AWS region where the assets will be deployed | `string` | n/a | yes |
| <a name="input_resource"></a> [resource](#input\_resource) | (Required) Indicates the resource to be created | `string` | n/a | yes |
## Modules

No modules.
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_asg_tags"></a> [asg\_tags](#output\_asg\_tags) | Tags which are appropriate auto scaling group (i.e. as a list of maps). See: https://www.terraform.io/docs/providers/aws/r/autoscaling_group.html |
| <a name="output_tags"></a> [tags](#output\_tags) | Tags which are applicable to all resources - map of `{key: value}` pairs |
