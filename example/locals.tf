locals {
  aws_auth_template = templatefile("${path.module}/templates/aws_auth_template.yml.tpl", {
    role_cluster = module.eks.cluster_role_arn
  })
}
