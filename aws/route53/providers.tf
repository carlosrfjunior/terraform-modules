provider "aws" {
  region  = var.region
  profile = var.profile
  default_tags {
    tags = module.tagging.tags
  }
}

provider "aws" {
  alias   = "route53"
  region  = try(var.aws_route53, null) == null ? var.region : try(var.aws_route53.aws_region_parent, var.region)
  profile = try(var.aws_route53, null) == null ? var.profile : try(var.aws_route53.aws_profile_parent, var.profile)
  default_tags {
    tags = module.tagging.tags
  }
}
