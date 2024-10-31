resource "kubernetes_config_map_v1_data" "aws_auth" {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    "mapRoles" = local.aws_auth_template
  }

  force = true

  depends_on = [
    aws_eks_cluster.this,
    aws_eks_node_group.this
  ]
}