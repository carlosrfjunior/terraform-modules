  <p align="center">
    <a href="https://github.com/carlosrfjunior/terraform-modules">
      <image src="https://raw.githubusercontent.com/carlosrfjunior/carlosrfjunior/main/assets/gopher-iron-man-flying.png" style="width: 300px;">
    </a>
  </p>

# Terraform Modules

Custom terraform modules from AWS and other providers.

## Prerequisites

- [terraform](https://developer.hashicorp.com/terraform/install?product_intent=terraform)
- [terraform-docs](https://terraform-docs.io/user-guide/installation/)
- [pre-commit](https://pre-commit.com/#install)
- [pre-commit-terraform](https://github.com/antonbabenko/pre-commit-terraform?tab=readme-ov-file)
- [TFLint](https://github.com/terraform-linters/tflint)

## Pre-commit

A pre-commit automation has been added to keep repository documentation up to date.

```shell
pre-commit install
```

## Example of use

```hcl
module "module-name" {
  source = "git@github.com:carlosrfjunior/terraform-modules.git//<provider>/<subdir>/<resource>?ref=v1.0.0
}
```
