data "aws_subnets" "all_subnets" {
  filter {
    name   = "vpc-id"
    values = [aws_vpc.main.id]
  }
}

resource "aws_eks_cluster" "eks_cluster" {
  name     = "MoonActive"
  role_arn = aws_iam_role.eks_cluster.arn

  vpc_config {
    endpoint_private_access = false
    endpoint_public_access  = true

    subnet_ids = toset(data.aws_subnets.all_subnets.ids)
  }

  tags = {
    "alpha.eksctl.io/cluster-oidc-enabled" = "true"
  }

  tags_all = {
    "alpha.eksctl.io/cluster-oidc-enabled" = "true"
  }
  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.amazon_eks_cluster_policy,
    aws_iam_role_policy_attachment.amazon_eks_vpc_resource_controller,
  ]
}