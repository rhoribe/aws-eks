data "aws_caller_identity" "current" {}

# Data source to fetch the latest version of the 'vpc-cni' addon
data "aws_eks_addon_version" "vpc-cni" {
  addon_name         = "vpc-cni"
  kubernetes_version = aws_eks_cluster.this.version
  most_recent        = true
}

# Data source to fetch the latest version of the 'coredns' addon
data "aws_eks_addon_version" "coredns" {
  addon_name         = "coredns"
  kubernetes_version = aws_eks_cluster.this.version
  most_recent        = true
}

# Data source to fetch the latest version of the 'kube-proxy' addon
data "aws_eks_addon_version" "kubeproxy" {
  addon_name         = "kube-proxy"
  kubernetes_version = aws_eks_cluster.this.version
  most_recent        = true
}
