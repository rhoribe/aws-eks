
variable "cluster_name" {
  type        = string
  description = "Name of EKS"
}

variable "kubernetes_version" {
  type        = string
  description = "Kubernetes Version"
  validation {
    condition     = can(regex("^(1.3[0-9])$", var.kubernetes_version))
    error_message = "Cluster version must be 1.3[0-9]"
  }
}


variable "control_plane_logs_retention" {
  type        = number
  description = "Control Plane Logs Retention"
  validation {
    condition     = can(regex("^(7|14|30|60|90|120|150|180|365)$", var.control_plane_logs_retention))
    error_message = "Control Plane Logs Retention must be 7, 14, 30, 60, 90, 120, 150, 180 or 365"
  }
}

variable "log_group_class" {
  type        = string
  description = "Log Group Class"
  validation {
    condition     = can(regex("^(INFREQUENT_ACCESS|STANDARD)$", var.log_group_class))
    error_message = "Log Group Class must be INFREQUENT_ACCESS for dev  and  hom environments, and STANDARD for pro environment"
  }
}
###### Network

variable "vpc_id" {
  description = "ID of VPC to deploy to (only needed when not using subnets automatic lookup)"
  type        = string
  validation {
    condition     = can(regex("^(vpc-[0-9a-f]{17})$", var.vpc_id))
    error_message = "VPC ID must be in the form of vpc-xxxxxxxxxxxxxxxxx"
  }
}

variable "subnets_ids" {
  type        = list(string)
  description = "IDs of private subnets in VPC (only needed when not using subnets automatic lookup)"
}

variable "cidr_blocks" {
  type        = list(string)
  description = "cidrs for the private endpoint, most likely from the subnet (only needed when not using subnets automatic lookup)"
}

### Node Groups AMI Versions

variable "image_id" {
  description = "AMI for EKS"
  type        = string
  validation {
    condition     = can(regex("^(ami-[0-9a-f]{17})$", var.image_id))
    error_message = "Image ID must be in the form of ami-xxxxxxxxxxxxxxxxx"
  }
}


## Public CIDRs
variable "public_cidr_access" {
  description = "cidrs allowed to access the public endpoint"
  type        = list(string)
  default     = []
}

variable "node_groups" {
  type        = any
  description = "config block for node groups"
}

variable "aws_auth_template_file" {
  type        = any
  description = "AWS Auth Template File"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all resources"
}




