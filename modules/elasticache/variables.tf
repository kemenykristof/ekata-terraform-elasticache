variable "required_tags" {
  description = "Required tags for this resource"

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
  default     = ""
  description = " (Required) Group identifier. ElastiCache converts this name to lowercase. Changing this value will re-create the resource."
}

variable "engine" {
  default     = ""
  description = "Elasticache engine type such as redis or memcached"
}

variable "node_type" {
  default     = "cache.t2.micro"
  description = "The node type for the nodes in the node cluster (cache.t2.micro & cache.t3.micro is free)"

}

variable "num_cache_nodes" {
  default     = 1
  description = "The initial number of cache nodes that the cache cluster will have. For Redis, this value must be 1. For Memcached, this value must be between 1 and 40."
}

variable "parameter_group_name" {
  default     = ""
  description = "The name of the parameter group to associate with this cache cluster."
}

variable "port" {
  default     = ""
  description = "The port number on which each of the cache nodes will accept connections. For Memcached the default is 11211, and for Redis the default port is 6379. "
}

variable "availability_zones" {
  type        = list(string)
  default     = ["us-east-2", "eu-west-1", "ap-east-1"]
  description = "Availability Zone for the cache cluster."
}
