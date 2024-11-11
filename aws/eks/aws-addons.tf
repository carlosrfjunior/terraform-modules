

module "aws_addons" {
  source = "./submodules/aws-addons"

  # region = var.region

  cluster_name           = time_sleep.wait_for_resources.triggers.cluster_name
  cluster_addons         = var.cluster_addons
  cluster_addons_enabled = var.cluster_addons_enabled

  # Custom
  vpc_cni                = local.vpc_cni
  coredns                = var.coredns
  eks_pod_identity_agent = var.eks_pod_identity_agent
  kube_proxy             = var.kube_proxy
  ebs_csi_driver         = var.ebs_csi_driver
  efs_csi_driver         = var.efs_csi_driver

  tags = module.tagging.tags

  depends_on = [module.vpc]

}
