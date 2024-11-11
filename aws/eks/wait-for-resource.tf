resource "time_sleep" "wait_for_resources" {

  create_duration = "60s"

  triggers = {
    cluster_name     = module.eks.cluster_name
    cluster_endpoint = module.eks.cluster_endpoint
    cluster_version  = module.eks.cluster_version
    cluster_status   = module.eks.cluster_status
  }

}
