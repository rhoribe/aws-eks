locals {
  user_data = base64encode(templatefile("${path.module}/templates/userdata/bootstrap.sh.tpl", {
    CLUSTER_ID         = aws_eks_cluster.this.id,
    APISERVER_ENDPOINT = aws_eks_cluster.this.endpoint,
    B64_CLUSTER_CA     = aws_eks_cluster.this.certificate_authority[0].data,
  }))

  aws_auth_template = var.aws_auth_template_file


  node_groups = {
    for name, definition in var.node_groups :
    name => {
      name                    = name
      instance_types          = definition["instance_types"]
      desired_capacity        = definition["desired_capacity"]
      max_capacity            = definition["max_capacity"]
      min_capacity            = definition["min_capacity"]
      capacity_type           = definition["capacity_type"]
      launch_template_id      = aws_launch_template.this[name].id
      launch_template_version = aws_launch_template.this[name].default_version
      volume_size             = try(definition["volume_size"], "")
      volume_type             = try(definition["volume_type"], "")
      iops                    = try(definition["iops"], "")
      throughput              = try(definition["throughput"], "")
      subnets_ids             = var.subnets_ids
      labels                  = try(definition["labels"], {})
    }
  }
}
