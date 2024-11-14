locals {
  principal_root = format("arn:aws:iam::%s:root", data.aws_caller_identity.current.account_id)
}
module "aws_ecr" {
  count   = length(var.ecr_name_list)
  source  = "terraform-aws-modules/ecr/aws"
  version = "~> 2.2"

  repository_name                 = var.ecr_name_list[count.index]
  repository_image_tag_mutability = var.repository_image_tag_mutability
  repository_read_write_access_arns = [
    local.principal_root,
    aws_iam_role.github_actions_role.arn
  ]
  repository_lifecycle_policy = jsonencode(var.repository_lifecycle_policy)

  tags = module.tagging.tags

  # depends_on = [aws_iam_role.github_actions_role]
}
