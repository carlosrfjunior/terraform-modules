module "tagging" {
  source                = "../../tagging"
  enabled               = var.tags_enabled
  application_id        = var.tags == null || try(var.tags.application_id, null) == null ? "" : var.tags.application_id
  business_unit_id      = var.tags == null || try(var.tags.business_unit_id, null) == null ? "" : var.tags.business_unit_id
  cost_center           = var.tags == null || try(var.tags.cost_center, null) == null ? "" : var.tags.cost_center
  owner                 = var.tags == null || try(var.tags.owner, null) == null ? "" : var.tags.owner
  layer_id              = var.tags == null || try(var.tags.layer_id, null) == null ? "" : var.tags.layer_id
  environment_id        = var.tags == null || try(var.tags.environment_id, null) == null ? "" : var.tags.environment_id
  operations_owner      = var.tags == null || try(var.tags.operations_owner, null) == null ? "" : var.tags.operations_owner
  disaster_recovery_rpo = var.tags == null || try(var.tags.disaster_recovery_rpo, null) == null ? "" : var.tags.disaster_recovery_rpo
  data_classification   = var.tags == null || try(var.tags.data_classification, null) == null ? "" : var.tags.data_classification
  compliance_framework  = var.tags == null || try(var.tags.compliance_framework, null) == null ? "" : var.tags.compliance_framework
  profile               = var.profile
  region                = var.region
}
