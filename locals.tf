locals {
  resource_full_name     = "cache-demo"
  bastion_security_group = "${local.resource_full_name}-bastion"
  cache_security_group   = "${local.resource_full_name}-cache"
}
