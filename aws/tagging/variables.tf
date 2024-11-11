variable "owner" {
  description = "(Required) Indicates the owner of the resource."
  type        = string

  validation {
    condition     = contains(local.owners, var.owner)
    error_message = "The environment value should be one of - ${join(",", local.owners)}\nReference: ${local.doc_url}"
  }
}

variable "cost_center" {
  description = "(Required) Indicates the cost center associated with the resource."
  type        = string
  validation {
    condition     = contains(local.cost_center, var.cost_center)
    error_message = "The cost-center value should be one of - ${join(",", local.cost_center)}\nReference: ${local.doc_url}"
  }
}

variable "environment" {
  description = "(Required) Indicates the lifecycle stage for the resource."
  type        = string

  validation {
    condition     = contains(local.environments, var.environment)
    error_message = "The environment value should be one of - ${join(",", local.environments)}\nReference: ${local.doc_url}"
  }
}

variable "product" {
  description = "(Required) Indicates the product associated with the resource."
  type        = string
  validation {
    condition     = length(var.product) > 1
    error_message = "Please enter a valid product. Example: Insight, Databricks e etc.\nReference: ${local.doc_url}"
  }
}

variable "resource" {
  description = "(Required) Indicates the resource to be created"
  type        = string
  validation {
    condition     = length(var.resource) > 1
    error_message = "Indicate the resource to be created. Example: ${join(",", local.resources)}\nReference: ${local.doc_url}"
  }
}

variable "data_classification" {
  description = "(Required) Identifies whether the resource contains, stores, or uses any type of special or sensitive data."
  type        = string
  validation {
    condition     = contains(local.data_classification, var.data_classification)
    error_message = "The data-classification value should be one of - ${join(",", local.data_classification)}\nReference: ${local.doc_url}"
  }
}

variable "managed_by" {
  description = "(Optional) The framework, tool, and/or method that created this resource."
  type        = string
  default     = "terraform"

  validation {
    condition     = can(regex("^terraform$", var.managed_by))
    error_message = "The managed-by value should be 'terraform' since this is written in terraform.\nReference: ${local.doc_url}"
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
