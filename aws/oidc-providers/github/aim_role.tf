locals {
  oidc_provider_arn = aws_iam_openid_connect_provider.github.arn
  repo_list         = [for git in try(var.github, {}) : format("repo:%s:ref:refs/heads/%s", git.repo, git.branch)]
  resource_name     = format("%s%s%s", title(var.tags.owner), title(var.tags.environment), title(var.tags.resource))
}

data "aws_iam_policy_document" "github_assume_role_policy" {
  statement {
    sid     = ""
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:sub"
      values   = local.repo_list
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = var.client_id_list
    }

    principals {
      type        = "Federated"
      identifiers = [local.oidc_provider_arn]
    }
  }
}

resource "aws_iam_role" "github_actions_role" {
  name               = "GHA-AssumeRole-${local.resource_name}"
  assume_role_policy = data.aws_iam_policy_document.github_assume_role_policy.json

  managed_policy_arns = concat(
    var.managed_policy_arns,
    [
      try(aws_iam_policy.ecr_aim_policy[0].arn, ""),
      try(aws_iam_policy.eks_aim_policy[0].arn, "")
    ]
  )

  dynamic "inline_policy" {
    for_each = var.inline_policy
    content {
      name   = inline_policy.value.name
      policy = inline_policy.value.policy
    }
  }
}
