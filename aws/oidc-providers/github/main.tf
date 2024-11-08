/*
* # AWS IAM Provider for Github
* This module is intended for configuring the integration between AWS and Github via AWS IAM OIDC Provider.
*
* **References:**
* - https://aws.amazon.com/blogs/security/use-iam-roles-to-connect-github-actions-to-actions-in-aws/
* - https://docs.github.com/en/actions/security-for-github-actions/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services
*/
resource "aws_iam_openid_connect_provider" "github" {
  url             = var.oidc_url
  client_id_list  = var.client_id_list
  thumbprint_list = var.thumbprint_list

}
