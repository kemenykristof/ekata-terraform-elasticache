variable "required_tags" {
  description = "Required tags for this resource: Owner, Service, Name, Classification"

  validation {
    condition     = contains(["Data Services", "Platform API", "Infrastructure", "Web"], var.required_tags.owner)
    error_message = "Error: wrong owner specified, possible options: \"Data Services\", \"Platform API\", \"Infrastructure\", \"Web\"."
  }

  validation {
    condition     = var.required_tags.service != null
    error_message = "Error: no value was defined for service"
  }

  validation {
    condition     = var.required_tags.name != null
    error_message = "Error: no value was defined for name"
  }

  validation {
    condition     = contains(["Internal", "Confidential", "Public"], var.required_tags.classification)
    error_message = "Error: wrong classification specified, possible options: \"Internal\", \"Confidential\", \"Public\"."
  }
}

variable "additional_tags" {
  type    = map(any)
  default = {}
}

variable "cluster_id" {
  type        = string
  default     = "cluster-test"
  description = " (Required) Group identifier. ElastiCache converts this name to lowercase. Changing this value will re-create the resource."
}


variable "node_type" {
  default     = "cache.t2.micro"
  description = "The node type for the nodes in the node cluster (cache.t2.micro & cache.t3.micro is free)"

}

variable "num_node_groups" {
  default     = 3
  description = "Number of node groups (shards) for this Redis replication group. Changing this number will trigger an online resizing operation before other settings modifications."
}

variable "replicas_per_node_group" {
  default     = 1
  description = "Number of replica nodes in each node group. Valid values are 0 to 5. Changing this number will trigger an online resizing operation before other settings modifications."
}

variable "parameter_group_name" {
  default     = ""
  description = "The name of the parameter group to associate with this cache cluster."
}

variable "port" {
  description = "The port number on which each of the cache nodes will accept connections. For Memcached the default is 11211, and for Redis the default port is 6379. "
}

variable "description" {
  description = "User-created description for the replication group. Must not be empty."
}

variable "transit_encryption_enabled" {
  type    = bool
  default = true
}

variable "at_rest_encryption_enabled" {
  type    = bool
  default = true
}

variable "automatic_failover_enabled" {
  default     = true
  description = "Must be enabled for Redis (cluster mode enabled) replication groups. Specifies whether a read-only replica will be automatically promoted to read/write primary if the existing primary fails. If enabled, num_node_groups/num_cache_clusters must be greater than 1. "
}

variable "redis_version" {
  description = "Redis engine version to use"
  type        = string
  default     = "6.0"
}
