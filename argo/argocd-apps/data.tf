data "aws_eks_cluster" "eks" {
  name       = var.cluster_name
  depends_on = [time_sleep.eks_status]
}

data "aws_eks_cluster_auth" "eks" {
  name = var.cluster_name

  ### Avoid enabling depends_on due to the error below:
  # Error: Kubernetes cluster unreachable: invalid configuration: no configuration has been provided,
  # try setting KUBERNETES_MASTER environment variable
  depends_on = [time_sleep.eks_status]
}
