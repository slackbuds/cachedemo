resource "aws_security_group" "cache" {
  name   = local.cache_security_group
  vpc_id = var.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "cache_from_bastion" {
  security_group_id            = aws_security_group.cache.id
  referenced_security_group_id = aws_security_group.bastion.id
  ip_protocol                  = "tcp"
  from_port                    = 6379
  to_port                      = 6379
}

resource "aws_elasticache_serverless_cache" "cache" {
  name               = local.resource_full_name
  engine             = "valkey"
  subnet_ids         = [data.aws_subnets.current.ids[0], data.aws_subnets.current.ids[1], data.aws_subnets.current.ids[2]]
  security_group_ids = [aws_security_group.cache.id]
  cache_usage_limits {
    data_storage {
      maximum = 1
      unit    = "GB"
    }
    ecpu_per_second {
      maximum = 1000
    }
  }
}
