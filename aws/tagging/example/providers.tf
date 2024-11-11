provider "aws" {
  default_tags {
    tags = module.tagging.tags
  }
}
