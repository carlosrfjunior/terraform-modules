provider "aws" {
  region  = var.region
  profile = var.profile
  default_tags {
    tags = module.tagging.tags
  }
  ignore_tags {
    key_prefixes = ["*created-by*"]
  }
}

provider "aws" {
  alias   = "route53"
  region  = try(var.aws_route53, null) == null ? var.region : try(var.aws_route53.aws_region, var.region)
  profile = try(var.aws_route53, null) == null ? var.profile : try(var.aws_route53.aws_profile, var.profile)
  default_tags {
    tags = module.tagging.tags
  }
  ignore_tags {
    key_prefixes = ["*created-by*"]
  }
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.default.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.default.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.default.token
}

provider "helm" {
  kubernetes {
    config_path    = "~/.kube/config"
    config_context = data.aws_eks_cluster.default.cluster_id
  }
  # kubernetes {
  #   host                   = data.aws_eks_cluster.default.endpoint
  #   cluster_ca_certificate = base64decode(data.aws_eks_cluster.default.certificate_authority[0].data)
  #   token                  = data.aws_eks_cluster_auth.default.token
  # }
}
