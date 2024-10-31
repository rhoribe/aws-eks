resource "aws_security_group" "this" {
  name   = format("%s-custom", var.cluster_name)
  vpc_id = var.vpc_id
  egress {
    from_port = 0
    to_port   = 0

    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge({
    Name = format("%s-cluster-sg", var.cluster_name)
  }, var.tags)

}

resource "aws_security_group_rule" "cluster_ingress_https" {
  description       = "cluster_ingress_https"
  cidr_blocks       = var.cidr_blocks
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.this.id
  type              = "ingress"
}

resource "aws_security_group_rule" "cluster_webhooks" {
  description = "webhooks"
  cidr_blocks = var.cidr_blocks
  from_port   = 8443
  to_port     = 9443
  protocol    = "tcp"

  security_group_id = aws_security_group.this.id
  type              = "ingress"
}

resource "aws_security_group_rule" "eks_coredns_tcp" {
  description       = "CoreDNS"
  cidr_blocks       = var.cidr_blocks
  from_port         = 53
  to_port           = 53
  protocol          = "tcp"
  security_group_id = aws_security_group.this.id
  type              = "ingress"
}

resource "aws_security_group_rule" "eks_coredns_udp" {
  description       = "CoreDNS"
  cidr_blocks       = var.cidr_blocks
  from_port         = 53
  to_port           = 53
  protocol          = "udp"
  security_group_id = aws_security_group.this.id
  type              = "ingress"
}

resource "aws_security_group_rule" "nodeport_master" {
  cidr_blocks       = var.cidr_blocks
  from_port         = 30000
  to_port           = 32768
  description       = "nodeport"
  protocol          = "tcp"
  security_group_id = aws_eks_cluster.this.vpc_config[0].cluster_security_group_id
  type              = "ingress"
}

resource "aws_security_group_rule" "nodeport_master_udp" {
  cidr_blocks       = var.cidr_blocks
  from_port         = 30000
  to_port           = 32768
  description       = "nodeport"
  protocol          = "udp"
  security_group_id = aws_eks_cluster.this.vpc_config[0].cluster_security_group_id
  type              = "ingress"
}

resource "aws_security_group_rule" "cluster_master_1" {
  cidr_blocks       = var.cidr_blocks
  from_port         = 10000
  to_port           = 12000
  description       = "cluster"
  protocol          = "tcp"
  security_group_id = aws_eks_cluster.this.vpc_config[0].cluster_security_group_id
  type              = "ingress"
}

resource "aws_security_group_rule" "cluster_master_2" {
  cidr_blocks       = var.cidr_blocks
  from_port         = 20000
  to_port           = 22000
  description       = "cluster"
  protocol          = "tcp"
  security_group_id = aws_eks_cluster.this.vpc_config[0].cluster_security_group_id
  type              = "ingress"
}

resource "aws_security_group_rule" "nodeport_cluster" {
  cidr_blocks       = var.cidr_blocks
  from_port         = 30000
  to_port           = 32768
  description       = "nodeport"
  protocol          = "tcp"
  security_group_id = aws_security_group.this.id
  type              = "ingress"
}

resource "aws_security_group_rule" "nodeport_cluster_udp" {
  cidr_blocks       = var.cidr_blocks
  from_port         = 30000
  to_port           = 32768
  description       = "nodeport"
  protocol          = "udp"
  security_group_id = aws_security_group.this.id
  type              = "ingress"
}

resource "aws_security_group_rule" "cluster_ports_1" {
  cidr_blocks       = var.cidr_blocks
  from_port         = 10000
  to_port           = 12000
  description       = "cluster"
  protocol          = "tcp"
  security_group_id = aws_security_group.this.id
  type              = "ingress"
}

resource "aws_security_group_rule" "cluster_ports_2" {
  cidr_blocks       = var.cidr_blocks
  from_port         = 20000
  to_port           = 22000
  description       = "cluster"
  protocol          = "tcp"
  security_group_id = aws_security_group.this.id
  type              = "ingress"
}

resource "aws_security_group_rule" "all" {
  from_port         = 0
  to_port           = 65535
  description       = "self"
  protocol          = "tcp"
  security_group_id = aws_security_group.this.id
  self              = true
  type              = "ingress"
}

resource "aws_security_group_rule" "all_control_plane" {
  from_port                = 0
  to_port                  = 65535
  description              = "control_plane"
  protocol                 = "tcp"
  source_security_group_id = aws_eks_cluster.this.vpc_config[0].cluster_security_group_id
  security_group_id        = aws_security_group.this.id
  type                     = "ingress"
}
