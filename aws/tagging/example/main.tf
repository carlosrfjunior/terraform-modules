
# ** Disable the resource tags **
module "tagging_disable" {
  source  = "../"
  enabled = false
  profile = var.aws_profile
  region  = var.aws_region
}

# ** Enable the resource tags **
module "tagging_prod_success" {
  source = "../"

  company_name          = "company"
  application_id        = "MobileApplicationsX"
  business_unit_id      = "DevOps"
  cost_center           = "Infrastructure"
  owner                 = "Operations"
  layer_id              = "Web_Layer"
  environment_id        = "Prod"
  operations_owner      = "Squad01"
  disaster_recovery_rpo = "6h"
  data_classification   = "Restricted"
  compliance_framework  = "PCI-DSS"
  profile               = var.aws_profile
  region                = var.aws_region
}

# ** The compliance framework and disaster recovery RPO is required in production environment!!! **
module "tagging_prod_fail" {
  source = "../"

  company_name          = "company"
  application_id        = "WebApplicationsX"
  business_unit_id      = "DevOps"
  cost_center           = "Infrastructure"
  owner                 = "Operations"
  layer_id              = "Web_Layer"
  environment_id        = "Prod"
  operations_owner      = "Squad02"
  disaster_recovery_rpo = ""
  data_classification   = "Restricted"
  compliance_framework  = ""
  profile               = var.aws_profile
  region                = var.aws_region
}
