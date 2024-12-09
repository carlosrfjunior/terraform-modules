/*
* # AWS Tagging module
*
* The tagging system allows us to refine management and implement interaction strategies for better resource management. This module allows us to define the internal tag system for the corporation and gives us the possibility of identifying the parties involved.
* 
* **References:**
* 
* - https://docs.aws.amazon.com/whitepapers/latest/tagging-best-practices/tagging-best-practices.html
* - https://docs.aws.amazon.com/whitepapers/latest/tagging-best-practices/building-your-tagging-strategy.html
* - https://docs.aws.amazon.com/whitepapers/latest/tagging-best-practices/defining-and-publishing-a-tagging-schema.html
*
*/

locals {
  tags = {
    "company:owner"               = var.owner
    "company:cost-center"         = var.cost_center
    "company:environment"         = var.environment
    "company:product"             = var.product
    "company:resource"            = var.resource
    "company:data-classification" = var.data_classification
    "company:managed-by"          = var.managed_by
    "company:created-by"          = data.aws_caller_identity.current.user_id
  }
}

locals {

  doc_url = "[Tag Conversion Document Link]"

  owners = [
    "sre",
    "secops",
    "security",
    "ep",
    "checkout",
    "payments",
    "finance",
    "devops",
  ]

  data_classification = [
    "true",
    "false"
  ]

  cost_center = [
    "infrastructure",
    "development",
    "payments",
    "finance"
  ]

  environments = [
    "sandbox",
    "develop",
    "pre-prod",
    "quality",
    "production",
    "staging",
    "testing",
  ]

  resources = [
    "Lambda",
    "S3",
    "RDS",
    "EC2",
    "ArgoCD"
  ]
}
