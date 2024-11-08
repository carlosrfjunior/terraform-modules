output "access_entries" {
  description = "Map of access entries created and their attributes."
  value       = module.eks.access_entries
}
output "access_policy_associations" {
  description = "Map of eks cluster access policy associations created and their attributes."
  value       = module.eks.access_policy_associations
}
output "cloudwatch_log_group_arn" {
  description = "Arn of cloudwatch log group created."
  value       = module.eks.cloudwatch_log_group_arn
}
output "cloudwatch_log_group_name" {
  description = "Name of cloudwatch log group created."
  value       = module.eks.cloudwatch_log_group_name
}
output "cluster_addons" {
  description = "Map of attribute maps for all EKS cluster addons enabled."
  value       = module.eks.cluster_addons
}
output "cluster_arn" {
  description = "The Amazon Resource Name (ARN) of the cluster."
  value       = module.eks.cluster_arn
}
output "cluster_certificate_authority_data" {
  description = "Base64 encoded certificate data required to communicate with the cluster."
  value       = module.eks.cluster_certificate_authority_data
}
output "cluster_endpoint" {
  description = "Endpoint for your Kubernetes API server."
  value       = module.eks.cluster_endpoint
}
output "cluster_iam_role_arn" {
  description = "IAM role ARN of the EKS cluster."
  value       = module.eks.cluster_iam_role_arn
}
output "cluster_iam_role_name" {
  description = "IAM role name of the EKS cluster."
  value       = module.eks.cluster_iam_role_name
}
output "cluster_iam_role_unique_id" {
  description = "Stable and unique string identifying the IAM role."
  value       = module.eks.cluster_iam_role_unique_id
}
output "cluster_id" {
  description = "The ID of the EKS cluster. Note: currently a value is returned only for local EKS clusters created on Outposts."
  value       = module.eks.cluster_id
}
output "cluster_identity_providers" {
  description = "Map of attribute maps for all EKS identity providers enabled."
  value       = module.eks.cluster_identity_providers
}
output "cluster_ip_family" {
  description = "The IP family used by the cluster (e.g. ipv4 or ipv6)."
  value       = module.eks.cluster_ip_family
}
output "cluster_name" {
  description = "The name of the EKS cluster."
  value       = module.eks.cluster_name
}
output "cluster_oidc_issuer_url" {
  description = "The URL on the EKS cluster for the OpenID Connect identity provider."
  value       = module.eks.cluster_oidc_issuer_url
}
output "cluster_platform_version" {
  description = "Platform version for the cluster."
  value       = module.eks.cluster_platform_version
}
output "cluster_primary_security_group_id" {
  description = "Cluster security group that was created by Amazon EKS for the cluster. Managed node groups use this security group for control-plane-to-data-plane communication. Referred to as 'Cluster security group' in the EKS console."
  value       = module.eks.cluster_primary_security_group_id
}
output "cluster_security_group_arn" {
  description = "Amazon Resource Name (ARN) of the cluster security group."
  value       = module.eks.cluster_security_group_arn
}
output "cluster_security_group_id" {
  description = "ID of the cluster security group."
  value       = module.eks.cluster_security_group_id
}
output "cluster_service_cidr" {
  description = "The CIDR block where Kubernetes pod and service IP addresses are assigned from."
  value       = module.eks.cluster_service_cidr
}
output "cluster_status" {
  description = "Status of the EKS cluster. One of CREATING, ACTIVE, DELETING, FAILED."
  value       = module.eks.cluster_status
}
output "cluster_tls_certificate_sha1_fingerprint" {
  description = "The SHA1 fingerprint of the public key of the cluster's certificate."
  value       = module.eks.cluster_tls_certificate_sha1_fingerprint
}
output "cluster_version" {
  description = "The Kubernetes version for the cluster."
  value       = module.eks.cluster_version
}
output "eks_managed_node_groups" {
  description = "Map of attribute maps for all EKS managed node groups created."
  value       = module.eks.eks_managed_node_groups
}
output "eks_managed_node_groups_autoscaling_group_names" {
  description = "List of the autoscaling group names created by EKS managed node groups."
  value       = module.eks.eks_managed_node_groups_autoscaling_group_names
}
output "fargate_profiles" {
  description = "Map of attribute maps for all EKS Fargate Profiles created."
  value       = module.eks.fargate_profiles
}
output "kms_key_arn" {
  description = "The Amazon Resource Name (ARN) of the key."
  value       = module.eks.kms_key_arn
}
output "kms_key_id" {
  description = "The globally unique identifier for the key."
  value       = module.eks.kms_key_id
}
output "kms_key_policy" {
  description = "The IAM resource policy set on the key."
  value       = module.eks.kms_key_policy
}
output "node_security_group_arn" {
  description = "Amazon Resource Name (ARN) of the node shared security group."
  value       = module.eks.node_security_group_arn
}
output "node_security_group_id" {
  description = "ID of the node shared security group."
  value       = module.eks.node_security_group_id
}
output "oidc_provider" {
  description = "The OpenID Connect identity provider (issuer URL without leading https://)."
  value       = module.eks.oidc_provider
}
output "oidc_provider_arn" {
  description = "The ARN of the OIDC Provider if enable_irsa = true."
  value       = module.eks.oidc_provider_arn
}
output "self_managed_node_groups" {
  description = "Map of attribute maps for all self managed node groups created."
  value       = module.eks.self_managed_node_groups
}
output "self_managed_node_groups_autoscaling_group_names" {
  description = "List of the autoscaling group names created by self-managed node groups."
  value       = module.eks.self_managed_node_groups_autoscaling_group_names
}
output "vpc_arn" {
  description = "The ARN of the VPC."
  value       = module.vpc.vpc_arn
}
output "vpc_id" {
  description = "The ID of the VPC."
  value       = module.vpc.vpc_id
}
output "vpc_cidr_block" {
  description = "The CIDR block of the VPC."
  value       = module.vpc.vpc_cidr_block
}
output "vpc_secondary_cidr_blocks" {
  description = "The secondary CIDR blocks of the VPC."
  value       = module.vpc.vpc_secondary_cidr_blocks
}

output "vpc_intra_cidr_block" {
  description = "The CIDR block of the intra VPC."
  value       = module.vpc.intra_subnets_cidr_blocks

}
output "vpc_database_subnet_group" {
  description = "The ID of the database subnet group."
  value       = module.vpc.database_subnet_group
}
output "vpc_intra_subnets" {
  description = "List of IDs of intra subnets."
  value       = module.vpc.intra_subnets
}
output "vpc_private_subnets" {
  description = "List of IDs of private subnets."
  value       = module.vpc.private_subnets
}
output "vpc_public_subnets" {
  description = "List of IDs of public subnets."
  value       = module.vpc.public_subnets
}
output "aws_route_53_arn" {
  description = "The Amazon Resource Name (ARN) of the Hosted Zone."
  value       = values(aws_route53_zone.child)[*].arn
}
output "aws_route_53_zone_id" {
  description = "The Hosted Zone ID. This can be referenced by zone records."
  value       = values(aws_route53_zone.child)[*].zone_id
}
output "aws_route_53_name_servers" {
  description = "A list of name servers in associated (or default) delegation set. Find more about delegation sets in AWS docs."
  value       = values(aws_route53_zone.child)[*].name_servers
}
output "aws_route_53_primary_name_server" {
  description = "The Route 53 name server that created the SOA record."
  value       = values(aws_route53_zone.child)[*].primary_name_server
}

output "aws_acm_certificate" {
  description = "AWS ACM Certificate for new Host"
  value       = values(aws_acm_certificate.cert)[*].arn
}
