

## Full example implementation

### Variable
  ```hcl
variable "tags" {
  default     = {}
  type        = map(string)
  description = "(Optional) List of tags to be propagated across all assets."
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
  source              = "git@github.com:carlosrfjunior/terraform-modules.git//aws/tagging?ref=v1.0.0"
  product             = var.tags == null || try(var.tags.product == null, true, false) ? "" : var.tags.product
  environment         = var.tags == null || try(var.tags.environment == null, true, false) ? "" : var.tags.environment
  owner               = var.tags == null || try(var.tags.owner == null, true, false) ? "" : var.tags.owner
  cost-center         = var.tags == null || try(var.tags.cost-center == null, true, false) ? "" : var.tags.cost-center
  resource            = var.tags == null || try(var.tags.resource == null, true, false) ? "" : var.tags.resource
  data-classification = var.tags == null || try(var.tags.data-classification == null, true, false) ? "" : var.tags.data-classification
  profile             = var.aws_profile
  region              = var.aws_region
}
```


### Main
```hcl
locals {
  tags = {
    product             = "databricks"
    environment         = "dev"
    owner               = "data"
    cost-center         = "data"
    resource            = "workspace"
    data-classification = "false"
  }
}

module "module-name" {
  source      = "git@github.com:carlosrfjunior/terraform-modules.git//databricks/aws/workspace?ref=v1.0.0"
  aws_region  = "us-east-1"
  aws_profile = "carlosrfjunior-data-dev"
  prefix      = "carlosrfjunior-data-dev"
  profile     = "carlosrfjunior"
  account_id  = "xxxxx-xxxx-xxxx-xxxx-xxxxxxxxxx"
  cidr_block  = "10.4.0.0/16"
  tags        = local.tags
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cost-center"></a> [cost-center](#input\_cost-center) | (Required) Indicates the cost center associated with the resource. | `string` | n/a | yes |
| <a name="input_data-classification"></a> [data-classification](#input\_data-classification) | (Required) Identifies whether the resource contains, stores, or uses any type of special or sensitive data. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | (Required) Indicates the lifecycle stage for the resource. | `string` | n/a | yes |
| <a name="input_managed-by"></a> [managed-by](#input\_managed-by) | (Optional) The framework, tool, and/or method that created this resource. | `string` | `"terraform"` | no |
| <a name="input_owner"></a> [owner](#input\_owner) | (Required) Indicates the owner of the resource. | `string` | n/a | yes |
| <a name="input_product"></a> [product](#input\_product) | (Required) Indicates the product associated with the resource. | `string` | n/a | yes |
| <a name="input_profile"></a> [profile](#input\_profile) | (Optional) AWS Profile to provider | `string` | `"default"` | no |
| <a name="input_region"></a> [region](#input\_region) | (Required) AWS region where the assets will be deployed | `string` | n/a | yes |
| <a name="input_resource"></a> [resource](#input\_resource) | (Required) Indicates the resource to be created | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_asg_tags"></a> [asg\_tags](#output\_asg\_tags) | Tags which are appropriate auto scaling group (i.e. as a list of maps). See: https://www.terraform.io/docs/providers/aws/r/autoscaling_group.html |
| <a name="output_tags"></a> [tags](#output\_tags) | Tags which are applicable to all resources - map of `{key: value}` pairs |
