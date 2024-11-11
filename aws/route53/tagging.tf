module "tagging" {
  # source              = "git@github.com:carlosrfjunior/terraform-modules.git//aws/tagging?ref=main"
  source              = "../tagging"
  product             = var.tags == null || try(var.tags.product, null) == null ? "" : var.tags.product
  environment         = var.tags == null || try(var.tags.environment, null) == null ? "" : var.tags.environment
  owner               = var.tags == null || try(var.tags.owner, null) == null ? "" : var.tags.owner
  cost_center         = var.tags == null || try(var.tags.cost_center, null) == null ? "" : var.tags.cost_center
  resource            = var.tags == null || try(var.tags.resource, null) == null ? "" : var.tags.resource
  data_classification = var.tags == null || try(var.tags.data_classification, null) == null ? "" : var.tags.data_classification
  profile             = var.profile
  region              = var.region
}
