/*
* # Example :: AWS IAM Provider for Github
* - Basic example code
*/
locals {
  tags = {
    application_id        = "WebApplicationsX"
    business_unit_id      = "DevOps"
    cost_center           = "Infrastructure"
    owner                 = "Operations"
    layer_id              = "Web_Layer"
    environment_id        = "Prod"
    operations_owner      = "Squad01"
    disaster_recovery_rpo = ""
    data_classification   = "Restricted"
    compliance_framework  = ""
  }
}

module "owner_env_suffix_resource" {
  source = "../"

  region  = "us-east-1"
  profile = "company-env"
  # inline_policy = jsondecode({})
  managed_policy_arns = []

  iam_access_entries_enabled = {
    ecr = false
    eks = false
  }

  cluster_arn_list = []
  ecr_name_list    = []
  namespace_list   = []

  tags = local.tags

  github = [
    {
      repo   = "company/repo1"
      branch = "main"
    },
    {
      repo   = "company/repo2"
      branch = "main"
    }
  ]

}
