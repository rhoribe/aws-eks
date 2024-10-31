
#### Cadastro Power Node Group
resource "aws_eks_node_group" "this" {
  for_each        = local.node_groups
  node_group_name = each.value.name
  cluster_name    = aws_eks_cluster.this.id
  node_role_arn   = aws_iam_role.eks_worker_role.arn
  subnet_ids      = each.value.subnets_ids
  instance_types  = each.value.instance_types
  capacity_type   = each.value.capacity_type
  labels          = each.value.labels

  scaling_config {
    desired_size = each.value.desired_capacity
    max_size     = each.value.max_capacity
    min_size     = each.value.min_capacity
  }

  launch_template {
    id      = aws_launch_template.this[each.key].id
    version = aws_launch_template.this[each.key].default_version
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [scaling_config[0].desired_size]
  }

  tags = merge({
    "Name" = each.value.name
  }, var.tags)

  depends_on = [
    aws_eks_cluster.this
  ]
}