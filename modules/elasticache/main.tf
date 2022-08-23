resource "aws_elasticache_replication_group" "redis-cluster" {
  replication_group_id         = var.cluster_id
  description                  = var.description
  node_type                    = var.node_type
  transit_encryption_enabled   = var.transit_encryption_enabled
  at_rest_encryption_enabled   = var.at_rest_encryption_enabled
  parameter_group_name         = var.parameter_group_name
  port                         = var.port
  preferred_availability_zones = var.availability_zones
  num_node_groups              = var.num_node_groups
  replicas_per_node_group      = var.replicas_per_node_group

}