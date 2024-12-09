variable "enabled" {
  description = "(Optional) A boolean flag to enable/disable the tagging module."
  type        = bool
  default     = true
}
variable "application_id" {
  description = "(Required) Indicates the application ID associated with the resource."
  type        = string
  default     = ""
  validation {
    condition     = var.enabled ? contains(local.applications, var.application_id) : true
    error_message = "The application id value should be one of - ${join(",", local.applications)}\nReference: ${local.ref_url}"
  }
}
variable "business_unit_id" {
  description = "(Required) Indicates the business unit ID associated with the resource."
  type        = string
  default     = ""
  validation {
    condition     = var.enabled ? contains(local.business_units, var.business_unit_id) : true
    error_message = "The business unit id value should be one of - ${join(",", local.business_units)}\nReference: ${local.ref_url}"
  }

}
variable "owner" {
  description = "(Required) Indicates the owner of the resource."
  type        = string
  default     = ""
  validation {
    condition     = var.enabled ? contains(local.owners, var.owner) : true
    error_message = "The environment value should be one of - ${join(",", local.owners)}\nReference: ${local.ref_url}"
  }
}

variable "layer_id" {
  description = "(Required) Indicates the layer ID associated with the resource."
  type        = string
  default     = ""
}

variable "cost_center" {
  description = "(Required) Indicates the cost center associated with the resource."
  type        = string
  default     = ""
  validation {
    condition     = var.enabled ? contains(local.cost_center, var.cost_center) : true
    error_message = "The cost-center value should be one of - ${join(",", local.cost_center)}\nReference: ${local.ref_url}"
  }
}

variable "environment_id" {
  description = "(Required) Indicates the lifecycle stage for the resource."
  type        = string
  default     = ""

  validation {
    condition     = var.enabled ? contains(local.environments, var.environment_id) : true
    error_message = "The environment-id value should be one of - ${join(",", local.environments)}\nReference: ${local.ref_url}"
  }
}

variable "operations_owner" {
  description = "(Required) Indicates the operations owner of the resource."
  type        = string
  default     = ""

  validation {
    condition     = var.enabled ? contains(local.operations_owners, var.operations_owner) : true
    error_message = "The operations-owner value should be one of - ${join(",", local.owners)}\nReference: ${local.ref_url}"
  }

}

variable "disaster_recovery_rpo" {
  description = "(Required) Indicates the recovery point objective (RPO) for the resource."
  type        = string
  default     = ""
  validation {
    condition     = var.enabled ? contains(local.rpo, var.disaster_recovery_rpo) && can(regex("^Prod$", var.environment_id)) : true
    error_message = "The disaster-recovery-rpo value should be one of - ${join(",", local.rpo)}\nReference: ${local.ref_url}"
  }

}

variable "data_classification" {
  description = "(Required) Identifies whether the resource contains, stores, or uses any type of special or sensitive data."
  type        = string
  default     = ""
  validation {
    condition     = var.enabled ? contains(local.data_classification, var.data_classification) : true
    error_message = "The data-classification value should be one of - ${join(",", local.data_classification)}\nReference: ${local.ref_url}"
  }
}

variable "compliance_framework" {
  description = "(Required) Indicates the compliance framework associated with the resource."
  type        = string
  default     = ""
  validation {
    condition     = var.enabled ? contains(local.compliance_framework, var.compliance_framework) && can(regex("^Prod$", var.environment_id)) : true
    error_message = "The compliance-framework value should be one of - ${join(",", local.compliance_framework)}\nReference: ${local.ref_url}"
  }

}

variable "managed_by" {
  description = "(Optional) The framework, tool, and/or method that created this resource."
  type        = string
  default     = "terraform"

  validation {
    condition     = var.enabled ? can(regex("^terraform$", var.managed_by)) : true
    error_message = "The managed-by value should be 'terraform' since this is written in terraform.\nReference: ${local.ref_url}"
  }
}

variable "region" {
  type        = string
  description = "(Required) AWS region where the assets will be deployed"
}
variable "profile" {
  type        = string
  description = "(Optional) AWS Profile to provider"
  default     = "default"
}
