resource "aws_launch_template" "this" {
  for_each               = var.node_groups
  name                   = each.key
  description            = "Default Launch-Template"
  update_default_version = true

  image_id = var.image_id

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size           = each.value["volume_size"]
      volume_type           = each.value["volume_type"]
      iops                  = each.value["iops"]
      throughput            = each.value["throughput"]
      delete_on_termination = true
      encrypted             = true
    }
  }

  monitoring {
    enabled = true
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_put_response_hop_limit = 2
    http_tokens                 = "required"
    instance_metadata_tags      = "enabled"
  }

  network_interfaces {
    device_index                = 0
    associate_public_ip_address = false
    delete_on_termination       = true
    security_groups             = [aws_eks_cluster.this.vpc_config[0].cluster_security_group_id]
  }

  user_data = local.user_data

  ebs_optimized = true

  tag_specifications {
    resource_type = "instance"
    tags = merge({
      Name = each.key
    }, var.tags)
  }


  lifecycle {
    create_before_destroy = true
  }
}