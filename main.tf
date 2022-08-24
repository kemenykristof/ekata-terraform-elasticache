resource "aws_elasticache_global_replication_group" "default" {
  global_replication_group_id_suffix = "replica"
  primary_replication_group_id       = aws_elasticache_replication_group.redis_cluster_primary.id
}

#Module for AWS Elasticache Redis Cluster 
resource "aws_elasticache_replication_group" "redis_cluster_primary" {
  provider                   = aws.us-east-2
  replication_group_id       = var.cluster_id
  description                = var.description
  node_type                  = var.node_type
  engine                     = "redis"
  engine_version             = var.redis_version
  transit_encryption_enabled = var.transit_encryption_enabled
  at_rest_encryption_enabled = var.at_rest_encryption_enabled
  parameter_group_name       = aws_elasticache_parameter_group.redis_parameters.name
  port                       = var.port
  automatic_failover_enabled = var.automatic_failover_enabled
  num_node_groups            = var.num_node_groups
  replicas_per_node_group    = var.replicas_per_node_group

  depends_on = [
    aws_elasticache_parameter_group.redis_parameters
  ]

}

resource "aws_elasticache_parameter_group" "redis_parameters" {
  name   = "redis-cache-parameters"
  family = "redis6.x"

  parameter {
    name  = "maxmemory-policy"
    value = "allkeys-lru"
  }

}

resource "aws_elasticache_replication_group" "redis_cluster_secondary" {
  provider = aws.eu-west-1

  replication_group_id        = "redis-cluster-secondary"
  description                 = "secondary replication group"
  global_replication_group_id = aws_elasticache_global_replication_group.default.global_replication_group_id

  number_cache_clusters = var.num_node_groups
}

resource "aws_elasticache_replication_group" "redis_cluster_tertiary" {
  provider = aws.ap-east-1

  replication_group_id        = "redis-cluster-tertiary"
  description                 = "tertiary replication group"
  global_replication_group_id = aws_elasticache_global_replication_group.default.global_replication_group_id

  number_cache_clusters = var.num_node_groups
}