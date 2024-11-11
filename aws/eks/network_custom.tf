locals {

  # [Custom Networking](./docs/custom-networking.md)

  subnets_list              = { for k, v in data.aws_subnet.private[*] : v.availability_zone => v.id }
  vpc_cni_custom_networking = try(var.vpc_cni.custom_networking, null) == null ? false : true
  vpc_cni_custom = {
    init = {
      env = {
        DISABLE_TCP_EARLY_DEMUX : tostring(local.vpc_cni_custom_networking)
      }
    }
    env = {
      AWS_VPC_K8S_CNI_CUSTOM_NETWORK_CFG = tostring(local.vpc_cni_custom_networking)
      ENI_CONFIG_LABEL_DEF               = "topology.kubernetes.io/zone"
      ENI_CONFIG_ANNOTATION_DEF          = "k8s.amazonaws.com/eniConfig"
      ENABLE_POD_ENI                     = tostring(local.vpc_cni_custom_networking)
      POD_SECURITY_GROUP_ENFORCING_MODE  = "standard"
      ENABLE_PREFIX_DELEGATION           = tostring(local.vpc_cni_custom_networking)
    }
    eniConfig = {
      # Specifies whether ENIConfigs should be created
      create = local.vpc_cni_custom_networking # bool
      region = var.region
      subnets = { for k, v in local.subnets_list : k => {
        "id"             = v
        "securityGroups" = [module.eks.node_security_group_id] # [module.eks.cluster_primary_security_group_id,module.eks.cluster_security_group_id]
        }
      }
    }
  }

  vpc_cni_enabled = { for k, v in var.vpc_cni : k => v if k != "custom_networking" }
  vpc_cni_json    = jsonencode(merge(local.vpc_cni_enabled, local.vpc_cni_custom))
  vpc_cni         = jsondecode(local.vpc_cni_custom_networking ? local.vpc_cni_json : jsonencode(local.vpc_cni_enabled))
}
