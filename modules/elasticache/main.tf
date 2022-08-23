resource "aws_elasticache_cluster" "memcached-cluster" {
  cluster_id                   = var.cluster_id
  engine                       = var.engine
  node_type                    = var.node_type
  num_cache_nodes              = var.num_cache_nodes
  parameter_group_name         = var.parameter_group_name
  port                         = var.port
  preferred_availability_zones = var.availability_zones

}