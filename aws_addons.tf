# Resource to create the EKS addon using the fetched version
resource "aws_eks_addon" "vpc-cni" {
  cluster_name                = var.cluster_name
  addon_name                  = "vpc-cni"
  addon_version               = data.aws_eks_addon_version.vpc-cni.version
  resolve_conflicts_on_update = "OVERWRITE" # Defines how to handle update conflicts
  depends_on                  = [aws_eks_cluster.this]
}

# Resource to create the EKS addon for 'coredns' using the fetched version
resource "aws_eks_addon" "coredns" {
  cluster_name                = var.cluster_name
  addon_name                  = "coredns"
  addon_version               = data.aws_eks_addon_version.coredns.version
  resolve_conflicts_on_update = "OVERWRITE" # Defines how to handle update conflicts
  depends_on                  = [aws_eks_cluster.this]
}

# Resource to create the EKS addon for 'kube-proxy' using the fetched version
resource "aws_eks_addon" "kubeproxy" {
  cluster_name                = var.cluster_name
  addon_name                  = "kube-proxy"
  addon_version               = data.aws_eks_addon_version.kubeproxy.version
  resolve_conflicts_on_update = "OVERWRITE" # Defines how to handle update conflicts
  depends_on                  = [aws_eks_cluster.this]
}