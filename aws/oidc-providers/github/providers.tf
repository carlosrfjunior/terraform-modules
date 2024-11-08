provider "aws" {
  region  = var.region
  profile = var.profile

  default_tags {
    tags = module.tagging.tags
  }
}
