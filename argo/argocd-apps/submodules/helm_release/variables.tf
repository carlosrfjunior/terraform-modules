variable "create" {
  type        = bool
  default     = true
  description = "Do not create or remove the installed application. This option is useful to avoid creating resources that are conditional on another state or action."

}

# variable "activate_wait" {
#   type        = bool
#   default     = true
#   description = <<EOT
#   Enables the sleep feature to wait for the cluster to be created. Disable if the cluster has already been created to avoid a very long delay.
#  EOT
# }

# variable "cluster_name" {
#   type        = string
#   description = "(Required) Name of the EKS cluster."
# }

# variable "cluster_version" {
#   type        = string
#   description = "(Required) Kubernetes `<major>.<minor>` version to use for the EKS cluster (i.e.: `1.30`)"
# }

# variable "cluster_endpoint" {
#   type        = string
#   description = "(Required) Endpoint for your Kubernetes API server"

# }

# variable "cluster_oidc_provider_arn" {
#   type        = string
#   description = "(Reuired) The ARN of the cluster OIDC Provider"

# }

# variable "create_duration" {
#   type        = string
#   default     = "30s"
#   description = <<EOT
#   (Optional) (String) Time duration to delay resource creation.
#   For example, `30s` for `30` seconds or `5m` for `5 minutes`.
#   Updating this value by itself will not trigger a delay.
#   EOT
# }

# variable "helm_dependencies_list" {
#   type        = list(string)
#   default     = []
#   description = "List of dependencies that must be executed before installing the application."

# }

variable "additional_labels_prefix" {
  default     = "app.kubernetes.io/"
  type        = string
  description = "(Optional) Prefix for application labels in Kubernetes"
}

variable "additional_label_name" {
  default     = null
  type        = string
  description = "(Optional) Reference name for the additional labels parameter. **Example:** `global.additionalLabels`"
}

variable "tags" {
  default     = {}
  type        = map(string)
  description = "(Optional) the tags to add to created resources"
}

variable "helm" {
  type = object({
    chart                      = string                       # (String) Chart name to be installed. A path may be used.
    name                       = string                       # (String) Release name. The length must not be longer than 53 characters.
    version                    = string                       # (String) Specify the exact chart version to install. If this is not specified, the latest version is installed.
    namespace                  = string                       # (String) Namespace to install the release into. Defaults to default.
    repository                 = string                       # (String) Repository where to locate the requested chart. If is a URL the chart is installed without installing the repository.
    description                = optional(string, null)       # (String) Add a custom description
    atomic                     = optional(bool, false)        # (Boolean) If set, installation process purges chart on fail. The wait flag will be set automatically if atomic is used. Defaults to false.
    cleanup_on_fail            = optional(bool, false)        # (Boolean) Allow deletion of new resources created in this upgrade when upgrade fails. Defaults to false.
    create_namespace           = optional(bool, false)        # (Boolean) Create the namespace if it does not exist. Defaults to false.
    dependency_update          = optional(bool, false)        # (Boolean) Run helm dependency update before installing the chart. Defaults to false.
    devel                      = optional(bool, null)         # (Boolean) Use chart development versions, too. Equivalent to version '>0.0.0-0'. If version is set, this is ignored
    disable_crd_hooks          = optional(bool, null)         # (Boolean) Prevent CRD hooks from, running, but run other hooks. See helm install --no-crd-hook
    disable_openapi_validation = optional(bool, null)         # (Boolean) If set, the installation process will not validate rendered templates against the Kubernetes OpenAPI Schema. Defaults to false.
    disable_webhooks           = optional(bool, false)        # (Boolean) Prevent hooks from running.Defaults to false.
    force_update               = optional(bool, false)        # (Boolean) Force resource update through delete/recreate if needed. Defaults to false.
    keyring                    = optional(string, null)       # (String) Location of public keys used for verification. Used only if verify is true. Defaults to /.gnupg/pubring.gpg in the location set by home.
    lint                       = optional(bool, false)        # (Boolean) Run helm lint when planning. Defaults to false.
    max_history                = optional(number, 0)          # (Number) Limit the maximum number of revisions saved per release. Use 0 for no limit. Defaults to 0 (no limit).
    pass_credentials           = optional(bool, false)        # (Boolean) Pass credentials to all domains. Defaults to false.
    recreate_pods              = optional(bool, false)        # (Boolean) Perform pods restart during upgrade/rollback. Defaults to false.
    render_subchart_notes      = optional(bool, true)         # (Boolean) If set, render subchart notes along with the parent. Defaults to true.
    replace                    = optional(bool, false)        # (Boolean) Re-use the given name, even if that name is already used. This is unsafe in production. Defaults to false.
    repository_ca_file         = optional(string, null)       # (String) The Repositories CA File
    repository_cert_file       = optional(string, null)       # (String) The repositories cert file
    repository_key_file        = optional(string, null)       # (String) The repositories cert key file
    repository_password        = optional(string, null)       # (String, Sensitive) Password for HTTP basic authentication
    repository_username        = optional(string, null)       # (String) Username for HTTP basic authentication
    reset_values               = optional(bool, true)         # (Boolean) When upgrading, reset the values to the ones built into the chart. Defaults to false.
    reuse_values               = optional(bool, false)        # (Boolean) When upgrading, reuse the last release's values and merge in any overrides. If 'reset_values' is specified, this is ignored. Defaults to false.
    skip_crds                  = optional(bool, false)        # (Boolean) If set, no CRDs will be installed. By default, CRDs are installed if not already present. Defaults to false.
    timeout                    = optional(number, 300)        # (Number) Time in seconds to wait for any individual kubernetes operation. Defaults to 300 seconds.
    upgrade_install            = optional(bool, false)        # (Boolean) If true, the provider will install the release at the specified version even if a release not controlled by the provider is present: this is equivalent to running 'helm upgrade --install' with the Helm CLI. WARNING: this may not be suitable for production use -- see the 'Upgrade Mode' note in the provider documentation. Defaults to false.
    verify                     = optional(bool, false)        # (Boolean) Verify the package before installing it.Defaults to false.
    wait                       = optional(bool, false)        # (Boolean) Will wait until all resources are in a ready state before marking the release as successful. Defaults to true.
    wait_for_jobs              = optional(bool, false)        # (Boolean) If wait is enabled, will wait until all Jobs have been completed before marking the release as successful. Defaults to `false`.
    values                     = optional(list(string), null) # (List of String) List of values in raw yaml format to pass to helm.

    postrender = optional(
      list(object({
        binary_path = string
        args        = optional(string, null)
      }))
    , []) # (Block List, Max: 1) Postrender command configuration.

    set = optional(
      list(object({
        name  = string
        value = string
        type  = optional(string, null)
      }))
    , []) # (Block Set) Custom values to be merged with the values.

    set_list = optional(
      list(object({
        name  = string
        value = list(string)
      }))
    , []) # (Block List) Custom list values to be merged with the values.

    set_sensitive = optional(
      list(object({
        name  = string
        value = string
        type  = optional(string, null)
      }))
    , []) # (Block Set) Custom sensitive values to be merged with the values.

  })

  default = {
    chart      = ""
    name       = ""
    version    = ""
    namespace  = ""
    repository = ""
  }
  description = <<EOT
    A Release is an instance of a chart running in a Kubernetes cluster.
    A Chart is a Helm package. It contains all of the resource definitions necessary to run an application, tool, or service inside of a Kubernetes cluster.
    `helm_release` describes the desired status of a chart in a kubernetes cluster.
    Reference: https:#registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release
  EOT
}
