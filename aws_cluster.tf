resource "aws_eks_cluster" "this" {
  name     = var.cluster_name
  version  = var.kubernetes_version
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    security_group_ids      = [aws_security_group.this.id]
    subnet_ids              = var.subnets_ids
    endpoint_private_access = true
    endpoint_public_access  = true
    public_access_cidrs     = var.public_cidr_access
  }

  enabled_cluster_log_types = [
    "api", "audit", "authenticator", "controllerManager", "scheduler"
  ]

  encryption_config {
    provider {
      key_arn = aws_kms_key.this.arn
    }
    resources = ["secrets"]
  }

  tags = merge({
    "k8s.io/cluster-autoscaler/${var.cluster_name}" = "owned",
    "kubernetes.io/cluster/${var.cluster_name}"     = "shared",
    "Name"                                          = var.cluster_name

  }, var.tags)

  depends_on = [aws_cloudwatch_log_group.this]

}

data "tls_certificate" "this" {
  url        = aws_eks_cluster.this.identity[0].oidc[0].issuer
  depends_on = [aws_eks_cluster.this]
}

resource "aws_iam_openid_connect_provider" "this" {
  client_id_list = ["sts.amazonaws.com"]
  thumbprint_list = [
    data.tls_certificate.this.certificates[0].sha1_fingerprint,
    "9e99a48a9960b14926bb7f3b02e22da2b0ab7280"
  ]
  url = flatten(concat(aws_eks_cluster.this[*].identity[*].oidc.0.issuer, [""]))[0]
}