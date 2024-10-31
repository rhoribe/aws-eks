variable "cluster_name" {
  type        = string
  description = "Name of EKS"
  default     = "cluster-xpto"
}

variable "kubernetes_version" {
  type        = string
  description = "Kubernetes Version"
  default     = "1.30"
}

variable "environment" {
  type        = string
  description = "Environment (dev, hom, pro)"
  validation {
    condition     = can(regex("^(dev|hom|pro)$", var.environment))
    error_message = "Environment must be dev, hom or pro"
  }
}

variable "control_plane_logs_retention" {
  type        = number
  description = "Control Plane Logs Retention"
  default     = 7
}

###### Network
variable "vpc_id" {
  description = "ID of VPC to deploy to (only needed when not using subnets automatic lookup)"
  type        = map(string)
  default = {
    "dev" = "vpc-XXXXXXXXXXXXXXXXX"
    "hom" = "vpc-XXXXXXXXXXXXXXXXX"
    "pro" = "vpc-XXXXXXXXXXXXXXXXX"
  }
}

variable "subnets_ids" {
  type = map(list(string))
  default = {
    "dev" = ["subnet-XXXXXXXXXXXXXXXXX", "subnet-XXXXXXXXXXXXXXXXX", "subnet-XXXXXXXXXXXXXXXXX"]
    "hom" = ["subnet-XXXXXXXXXXXXXXXXX", "subnet-XXXXXXXXXXXXXXXXX", "subnet-XXXXXXXXXXXXXXXXX"]
    "pro" = ["subnet-XXXXXXXXXXXXXXXXX", "subnet-XXXXXXXXXXXXXXXXX", "subnet-XXXXXXXXXXXXXXXXX"]
  }
  description = "IDs of private subnets in VPC (only needed when not using subnets automatic lookup)"
}

variable "cidr_blocks" {
  type = map(list(string))
  default = {
    "dev" = ["XXX.XXX.XXX.XXX/XX", "XXX.XXX.XXX.XXX/XX", "XXX.XXX.XXX.XXX/XX"]
    "hom" = ["XXX.XXX.XXX.XXX/XX", "XXX.XXX.XXX.XXX/XX", "XXX.XXX.XXX.XXX/XX"]
    "pro" = ["XXX.XXX.XXX.XXX/XX", "XXX.XXX.XXX.XXX/XX", "XXX.XXX.XXX.XXX/XX"]
  }
  description = "cidrs for the private endpoint, most likely from the subnet (only needed when not using subnets automatic lookup)"
}

###  Node Groups
variable "node_groups" {
  type        = any
  description = "config block for node groups"
}

variable "log_group_class" {
  type        = string
  description = "Log Group Class"
  default     = "INFREQUENT_ACCESS"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all resources"
  default     = {}
}