module "eks" {
  source             = "git::https://github.com/rhoribe/aws-eks?ref=v1.0.0"
  cluster_name       = var.cluster_name
  kubernetes_version = var.kubernetes_version
  image_id           = data.aws_ssm_parameter.eks_ami.value


  ## Logs
  control_plane_logs_retention = var.control_plane_logs_retention
  log_group_class              = var.log_group_class

  ## Network
  vpc_id      = lookup(var.vpc_id, var.environment, "")
  subnets_ids = lookup(var.subnets_ids, var.environment, [])
  cidr_blocks = lookup(var.cidr_blocks, var.environment, [])

  ## Node Groups
  node_groups            = var.node_groups
  aws_auth_template_file = local.aws_auth_template

  ## Tags
  tags = var.tags
}
