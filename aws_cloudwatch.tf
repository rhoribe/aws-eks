resource "aws_cloudwatch_log_group" "this" {
  name              = "/aws/eks/${var.cluster_name}/cluster"
  retention_in_days = var.control_plane_logs_retention
  log_group_class   = var.log_group_class
  tags              = var.tags
}