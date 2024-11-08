locals {
  eks_enabled = try(var.iam_access_entries_enabled.eks, false) ? 1 : 0
}
data "aws_iam_policy_document" "eks_policy_document" {
  count = local.eks_enabled
  statement {
    sid       = "AllowAccessByResourceARN"
    effect    = "Allow"
    resources = var.cluster_arn_list
    actions   = ["eks:DescribeCluster"]
  }
  statement {
    sid       = "AllowAll"
    effect    = "Allow"
    resources = ["*"]
    actions   = ["eks:ListClusters"]
  }
}

resource "aws_iam_policy" "eks_aim_policy" {
  count  = local.eks_enabled
  name   = "AWS_EKS_OIDC_${local.resource_name}"
  policy = data.aws_iam_policy_document.eks_policy_document[0].json
}
