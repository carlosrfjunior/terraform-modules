locals {
  clusters = [for cluster in var.cluster_arn_list : split("/", cluster)]

  iam_access_entries = {
    for cluster in local.clusters : cluster[1] => {
      cluster_name  = cluster[1]
      principal_arn = aws_iam_role.github_actions_role.arn
      policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSViewPolicy"
    }
  }
}

resource "aws_eks_access_entry" "eks_access_entry" {
  for_each      = local.iam_access_entries
  cluster_name  = each.value.cluster_name
  principal_arn = each.value.principal_arn
  type          = "STANDARD"
}

resource "aws_eks_access_policy_association" "eks_policy_association" {
  for_each      = local.iam_access_entries
  cluster_name  = each.value.cluster_name
  policy_arn    = each.value.policy_arn
  principal_arn = each.value.principal_arn
  access_scope {
    type       = "namespace"
    namespaces = var.namespace_list
  }
}
