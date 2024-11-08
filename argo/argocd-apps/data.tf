# locals {
#   cluster_creating = var.cluster_status == "ACTIVE" ? 1 : 0
# }
# data "aws_iam_policy_document" "assume_role" {
#   statement {
#     effect = "Allow"

#     principals {
#       type        = "Service"
#       identifiers = ["pods.eks.amazonaws.com"]
#     }

#     actions = [
#       "sts:AssumeRole",
#       "sts:TagSession"
#     ]
#   }
# }

data "aws_eks_cluster" "eks" {
  name = var.cluster_name
}

data "aws_eks_cluster_auth" "eks" {
  name = var.cluster_name

  ### Avoid enabling depends_on due to the error below:
  # Error: Kubernetes cluster unreachable: invalid configuration: no configuration has been provided,
  # try setting KUBERNETES_MASTER environment variable
  # depends_on = [ time_sleep.eks_status ]
}
