output "bastion_key" {
  value = aws_instance.bastion.key_name
}

output "bastion_dns" {
  value = aws_instance.bastion.public_dns
}

output "cache_address" {
  value = aws_elasticache_serverless_cache.cache.endpoint[0].address
}
