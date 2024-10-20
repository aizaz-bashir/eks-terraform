output "zone_id" {
  value = aws_route53_zone.primary_zone.zone_id
}

output "eks_record" {
  value = aws_route53_record.eks_endpoint.fqdn
}

output "rds_record" {
  value = aws_route53_record.rds_endpoint.fqdn
}

output "rabbitmq_record" {
  value = aws_route53_record.rabbitmq_endpoint.fqdn
}
output "redis_record" {
  value = aws_route53_record.redis_endpoint.fqdn
}

output "domain_name" {
  value       = var.domain_name
  description = "The domain name for the Route 53 hosted zone."
}

