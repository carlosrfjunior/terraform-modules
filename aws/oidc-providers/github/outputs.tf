output "aws_assume_role_arn" {
  value       = aws_iam_role.github_actions_role.arn
  description = "Returns the ARN of the AWS Assume Role created for the Github Action."
}
