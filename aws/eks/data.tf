data "aws_availability_zones" "available" {
  state = "available"
}
data "aws_subnet" "private" {
  count  = length(module.vpc.intra_subnets)
  vpc_id = module.vpc.vpc_id
  id     = module.vpc.intra_subnets[count.index]
}

data "aws_eks_cluster" "default" {
  name       = module.eks.cluster_name
  depends_on = [module.eks.cluster_name]
}

data "aws_eks_cluster_auth" "default" {
  name = module.eks.cluster_name

  ### Avoid enabling depends_on due to the error below:
  # Error: Kubernetes cluster unreachable: invalid configuration: no configuration has been provided,
  # try setting KUBERNETES_MASTER environment variable
  depends_on = [module.eks.cluster_name]
}
