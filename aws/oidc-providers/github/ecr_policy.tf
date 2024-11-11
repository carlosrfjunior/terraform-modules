locals {
  ecr_enabled    = try(var.iam_access_entries_enabled.ecr, false) ? 1 : 0
  ecr_account_id = data.aws_caller_identity.current.account_id
  ecr_name_list  = [for name in var.ecr_name_list : format("arn:aws:ecr:%s:%s:repository/%s", var.region, local.ecr_account_id, name)]
}

data "aws_iam_policy_document" "ecr_document_policy" {
  count = local.ecr_enabled
  statement {
    sid       = "PrivateReadOnly"
    effect    = "Allow"
    resources = local.ecr_name_list

    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:BatchGetImage",
      "ecr:DescribeImageScanFindings",
      "ecr:DescribeImages",
      "ecr:DescribeRepositories",
      "ecr:GetAuthorizationToken",
      "ecr:GetDownloadUrlForLayer",
      "ecr:GetLifecyclePolicy",
      "ecr:GetLifecyclePolicyPreview",
      "ecr:GetRepositoryPolicy",
      "ecr:ListImages",
      "ecr:ListTagsForResource",
    ]
  }

  statement {
    sid       = "ReadWrite"
    effect    = "Allow"
    resources = local.ecr_name_list

    actions = [
      "ecr:CompleteLayerUpload",
      "ecr:InitiateLayerUpload",
      "ecr:PutImage",
      "ecr:UploadLayerPart",
    ]
  }

  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["*"]
    actions   = ["ecr:GetAuthorizationToken"]
  }
}

resource "aws_iam_policy" "ecr_aim_policy" {
  count  = local.ecr_enabled
  name   = "AWS_ECR_OIDC_${local.resource_name}"
  policy = data.aws_iam_policy_document.ecr_document_policy[0].json
}
