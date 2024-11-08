# Create IAM role for EKS worker nodes
resource "aws_iam_role" "eks_cluster_node_role" {
  name = "${var.cluster_name}-cluster-role"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "aws_eks_worker_node_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_cluster_node_role.name
}

resource "aws_iam_role_policy_attachment" "aws_eks_cni_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_cluster_node_role.name
}

resource "aws_iam_role_policy_attachment" "aws_ec2_container_registry_readonly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_cluster_node_role.name
}


data "aws_iam_policy_document" "eks_pod_identity_agent" {
  statement {
    effect = "Allow"
    actions = [
      "eks-auth:AssumeRoleForPodIdentity",
    ]
    resources = [
      "*",
    ]
  }
}
resource "aws_iam_policy" "eks_pod_identity_agent" {
  name   = "AssumeRoleForPodIdentity"
  path   = "/"
  policy = data.aws_iam_policy_document.eks_pod_identity_agent.json
}
resource "aws_iam_role_policy_attachment" "eks_pod_identity_agent" {
  for_each = module.eks.eks_managed_node_groups

  policy_arn = aws_iam_policy.eks_pod_identity_agent.arn
  role       = each.value.iam_role_name
}
