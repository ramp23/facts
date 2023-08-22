data "aws_subnets" "private_subnets" {
  filter {
    name   = "vpc-id"
    values = [aws_vpc.main.id]
  }

  tags = {
    Tier = "private"
  }

}

resource "aws_eks_node_group" "eks_node_group_on_demand" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "nodes-general"
  node_role_arn   = aws_iam_role.nodes_general.arn
  subnet_ids      = toset(data.aws_subnets.private_subnets.ids)

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  #   update_config {
  #     max_unavailable = 1
  #   }

  ami_type             = "AL2_x86_64"
  capacity_type        = "ON_DEMAND"
  instance_types       = ["t3.small"]
  force_update_version = false
  disk_size            = 20

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.

  depends_on = [
    aws_iam_role_policy_attachment.amazon_eks_worker_node_policy_general,
    aws_iam_role_policy_attachment.amazon_eks_cni_policy,
    aws_iam_role_policy_attachment.amazon_ec2_container_registry_readonly,
  ]

  labels = {
    role = "nodes_general"
  }
}