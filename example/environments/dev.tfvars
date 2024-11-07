environment = "dev"
node_groups = {
  node_group_infra = {
    instance_types   = ["t3a.micro", "t2.micro", "t3.small"]
    desired_capacity = 1
    max_capacity     = 3
    min_capacity     = 1
    capacity_type    = "SPOT"
    volume_size      = 25
    volume_type      = "gp3"
    iops             = 3000
    throughput       = 125
    labels = {
      "node-group" = "test"
    }
  }
}
