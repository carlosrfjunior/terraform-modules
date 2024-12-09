/*
* # AWS Tagging Module
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
    "company:cost-allocation:ApplicationId"  = var.application_id
    "company:cost-allocation:BusinessUnitId" = var.business_unit_id
    "company:cost-allocation:CostCenter"     = var.cost_center
    "company:cost-allocation:Owner"          = var.owner
    "company:access-control:LayerId"         = var.layer_id
    "company:automation:EnvironmentId"       = var.environment_id
    "company:automation:created-by"          = data.aws_caller_identity.current.user_id
    "company:automation:managed_by"          = var.managed_by
    "company:operations:Owner"               = var.operations_owner
    "company:disaster-recovery:rpo"          = var.disaster_recovery_rpo
    "company:data:classification"            = var.data_classification
    "company:compliance:framework"           = var.compliance_framework

  }
}

locals {

  ref_url = "https://docs.aws.amazon.com/whitepapers/latest/tagging-best-practices/defining-and-publishing-a-tagging-schema.html"

  applications = [
    "DataLakeX", "RetailSiteX", "WebApplicationsX", "MobileApplicationsX", "DataWarehouseX"
  ]

  business_units = [
    "Architecture", "DevOps", "Finance"
  ]

  owners = [
    "Marketing", "RetailSupport", "Payments", "Finance", "DevOps", "Security", "SRE", "Checkout", "EP", "Data", "Compliance", "Operations"
  ]

  cost_center = [
    "Infrastructure",
    "Development",
    "Payments",
    "Finance",
    "Marketing",
  ]

  environments = [
    "Sandbox",
    "Pre-prod",
    "Quality",
    "Prod",
    "Dev",
    "Test",
  ]

  operations_owners = [
    "Squad01", "Squad02", "Squad03", "Squad04", "Squad05", "Squad06", "Squad07", "Squad08", "Squad09", "Squad10"
  ]

  rpo = [
    "6h", "24h", "48h", "72h"
  ]

  data_classification = [
    "Public", "Private", "Confidential", "Restricted"
  ]

  compliance_framework = [
    "PCI-DSS", "HIPAA", "GDPR", "SOX", "ISO27001"
  ]

}
