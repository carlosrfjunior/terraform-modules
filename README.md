# terraform-modules

Custom terraform modules from AWS, Databricks and other providers.

## Prerequisites

- [terraform](https://developer.hashicorp.com/terraform/install?product_intent=terraform)
- [terraform-docs](https://terraform-docs.io/user-guide/installation/)
- [pre-commit](https://pre-commit.com/#install)
- [pre-commit-terraform](https://github.com/antonbabenko/pre-commit-terraform?tab=readme-ov-file)

### Homebrew

- If you are a macOS user, you can use Homebrew.

```shell
brew install terraform-docs
```

or

```shell
brew install terraform-docs/tap/terraform-docs
```

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
