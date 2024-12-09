<p align="center">
  <a href="https://github.com/carlosrfjunior/terraform-modules">
    <image src="https://raw.githubusercontent.com/carlosrfjunior/carlosrfjunior/main/assets/gopher-iron-man-flying.png" style="width: 300px;">
  </a>
</p>

# AWS Route53 Module

This module has the basic function of creating a new DNS record in AWS Route53 in a single account or cross-accounts.

## Full example implementation

### Main
```hcl
module "route53_domains" {
  source = "../"

  profile = "testing"
  region  = "us-east-1"

  aws_route53 = {

    meudominio_com = {
      private_zone = true
      # vpc_id           = ""
      record_dns_names = ["dev-meudominio.com"]
    }

  }

  tags = {
    product             = "aws"
    environment         = "testing"
    owner               = "sre"
    cost_center         = "infrastructure"
    resource            = "route53"
    data_classification = "false"
  }

}
```

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.75.0 |
| <a name="provider_aws.route53"></a> [aws.route53](#provider\_aws.route53) | 5.75.0 |
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.2 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.61 |
## Resources

| Name | Type |
|------|------|
| [aws_acm_certificate.cert](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_route53_record.cert_record](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.child_ns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_zone.child](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone) | resource |
| [aws_route53_zone.parent](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_route53"></a> [aws\_route53](#input\_aws\_route53) | (Required) Configure an existing DNS or create a new one in AWS Route53.<br/>  **Example:**<pre>aws_route53 = {<br/>    aws_region_parent  = ""     (Optional) Parent region of the registered AWS Route Hosted Zone.<br/>    aws_profile_parent = ""     (Optional) Parent profile of the registered AWS Route Hosted Zone.<br/>    register_name = {           (Required) Unique map identifier.<br/>      private_zone     = false  (Optional) Default: true. Informs whether the DNS is private or not.<br/>      parent_dns_name  = ""     (Optional) Parent DNS of the registered AWS Route Hosted Zone.<br/>      record_dns_names = []     (Required) List of domains that will be registered in the module's main profile. May or may not be the same as the Parent DNS record.<br/>    }<br/>  }</pre> | `any` | `{}` | no |
| <a name="input_profile"></a> [profile](#input\_profile) | (Optional) AWS Profile to provider | `string` | `"default"` | no |
| <a name="input_region"></a> [region](#input\_region) | (Required) AWS region to provider | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) the tags to add to created resources | `map(string)` | `{}` | no |
## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_tagging"></a> [tagging](#module\_tagging) | ../tagging | n/a |
## Outputs

No outputs.
