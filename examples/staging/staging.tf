provider "aws" {
  region = "us-east-2"
  alias  = "us-east-2"
}

provider "aws" {
  region = "eu-west-1"
  alias  = "eu-west-1"
}

provider "aws" {
  region = "ap-east-1"
  alias  = "ap-east-1"
}

resource "aws_vpc" "elasticache_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "Elasticache Redis vpc test"
  }
}

resource "aws_subnet" "elasticache_subnet" {
  vpc_id            = aws_vpc.elasticache_vpc.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "eu-west-1a"

  tags = {
    Name = "Elasticache Redis subnet test"
  }
}

resource "aws_elasticache_subnet_group" "redis_subnet" {
  name       = "Elasticache-Redis-subnet-group-test"
  subnet_ids = [aws_subnet.elasticache_subnet.id]
}


module "redis-cluster-staging" {
  source = "./../../"

  description             = "Elasticache Redis Staging cluster"
  port                    = 6379
  num_node_groups         = 2
  replicas_per_node_group = 1
  required_tags = {
    owner          = "Web"
    service        = "test-service"
    name           = "test-name"
    classification = "Internal"
  }
}





