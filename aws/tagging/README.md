<p align="center">
  <a href="https://github.com/carlosrfjunior/terraform-modules">
    <image src="https://raw.githubusercontent.com/carlosrfjunior/carlosrfjunior/main/assets/gopher-iron-man-flying.png" style="width: 300px;">
  </a>
</p>

# AWS Tagging Module

The tagging system allows us to refine management and implement interaction strategies for better resource management. This module allows us to define the internal tag system for the corporation and gives us the possibility of identifying the parties involved.

**References:**

- https://docs.aws.amazon.com/whitepapers/latest/tagging-best-practices/tagging-best-practices.html
- https://docs.aws.amazon.com/whitepapers/latest/tagging-best-practices/building-your-tagging-strategy.html
- https://docs.aws.amazon.com/whitepapers/latest/tagging-best-practices/defining-and-publishing-a-tagging-schema.html

## Full example implementation

### Variable
  ```hcl
variable "aws_region" {
  type        = string
  description = "(Required) AWS region where the assets will be deployed"
  default     = "us-east-1"
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

# ** Disable the resource tags **
module "tagging_disable" {
  source  = "../"
  enabled = false
  profile = var.aws_profile
  region  = var.aws_region
}

# ** Enable the resource tags **
module "tagging_prod_success" {
  source = "../"

  application_id        = "MobileApplicationsX"
  business_unit_id      = "DevOps"
  cost_center           = "Infrastructure"
  owner                 = "Operations"
  layer_id              = "Web_Layer"
  environment_id        = "Prod"
  operations_owner      = "Squad01"
  disaster_recovery_rpo = "6h"
  data_classification   = "Restricted"
  compliance_framework  = "PCI-DSS"
  profile               = var.aws_profile
  region                = var.aws_region
}

# ** The compliance framework and disaster recovery RPO is required in production environment!!! **
module "tagging_prod_fail" {
  source = "../"

  application_id        = "WebApplicationsX"
  business_unit_id      = "DevOps"
  cost_center           = "Infrastructure"
  owner                 = "Operations"
  layer_id              = "Web_Layer"
  environment_id        = "Prod"
  operations_owner      = "Squad02"
  disaster_recovery_rpo = ""
  data_classification   = "Restricted"
  compliance_framework  = ""
  profile               = var.aws_profile
  region                = var.aws_region
}
```


### Main
```hcl

# ** Disable the resource tags **
module "tagging_disable" {
  source  = "../"
  enabled = false
  profile = var.aws_profile
  region  = var.aws_region
}

# ** Enable the resource tags **
module "tagging_prod_success" {
  source = "../"

  application_id        = "MobileApplicationsX"
  business_unit_id      = "DevOps"
  cost_center           = "Infrastructure"
  owner                 = "Operations"
  layer_id              = "Web_Layer"
  environment_id        = "Prod"
  operations_owner      = "Squad01"
  disaster_recovery_rpo = "6h"
  data_classification   = "Restricted"
  compliance_framework  = "PCI-DSS"
  profile               = var.aws_profile
  region                = var.aws_region
}

# ** The compliance framework and disaster recovery RPO is required in production environment!!! **
module "tagging_prod_fail" {
  source = "../"

  application_id        = "WebApplicationsX"
  business_unit_id      = "DevOps"
  cost_center           = "Infrastructure"
  owner                 = "Operations"
  layer_id              = "Web_Layer"
  environment_id        = "Prod"
  operations_owner      = "Squad02"
  disaster_recovery_rpo = ""
  data_classification   = "Restricted"
  compliance_framework  = ""
  profile               = var.aws_profile
  region                = var.aws_region
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
| <a name="input_application_id"></a> [application\_id](#input\_application\_id) | (Required) Indicates the application ID associated with the resource. | `string` | `""` | no |
| <a name="input_business_unit_id"></a> [business\_unit\_id](#input\_business\_unit\_id) | (Required) Indicates the business unit ID associated with the resource. | `string` | `""` | no |
| <a name="input_compliance_framework"></a> [compliance\_framework](#input\_compliance\_framework) | (Required) Indicates the compliance framework associated with the resource. | `string` | `""` | no |
| <a name="input_cost_center"></a> [cost\_center](#input\_cost\_center) | (Required) Indicates the cost center associated with the resource. | `string` | `""` | no |
| <a name="input_data_classification"></a> [data\_classification](#input\_data\_classification) | (Required) Identifies whether the resource contains, stores, or uses any type of special or sensitive data. | `string` | `""` | no |
| <a name="input_disaster_recovery_rpo"></a> [disaster\_recovery\_rpo](#input\_disaster\_recovery\_rpo) | (Required) Indicates the recovery point objective (RPO) for the resource. | `string` | `""` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | (Optional) A boolean flag to enable/disable the tagging module. | `bool` | `true` | no |
| <a name="input_environment_id"></a> [environment\_id](#input\_environment\_id) | (Required) Indicates the lifecycle stage for the resource. | `string` | `""` | no |
| <a name="input_layer_id"></a> [layer\_id](#input\_layer\_id) | (Required) Indicates the layer ID associated with the resource. | `string` | `""` | no |
| <a name="input_managed_by"></a> [managed\_by](#input\_managed\_by) | (Optional) The framework, tool, and/or method that created this resource. | `string` | `"terraform"` | no |
| <a name="input_operations_owner"></a> [operations\_owner](#input\_operations\_owner) | (Required) Indicates the operations owner of the resource. | `string` | `""` | no |
| <a name="input_owner"></a> [owner](#input\_owner) | (Required) Indicates the owner of the resource. | `string` | `""` | no |
| <a name="input_profile"></a> [profile](#input\_profile) | (Optional) AWS Profile to provider | `string` | `"default"` | no |
| <a name="input_region"></a> [region](#input\_region) | (Required) AWS region where the assets will be deployed | `string` | n/a | yes |
## Modules

No modules.
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_asg_tags"></a> [asg\_tags](#output\_asg\_tags) | Tags which are appropriate auto scaling group (i.e. as a list of maps). See: https://www.terraform.io/docs/providers/aws/r/autoscaling_group.html |
| <a name="output_tags"></a> [tags](#output\_tags) | Tags which are applicable to all resources - map of `{key: value}` pairs |
