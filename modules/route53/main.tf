# Create a Route 53 Hosted Zone
resource "aws_route53_zone" "primary_zone" {
  name = var.domain_name

  vpc {
    vpc_id = var.vpc_id
  }

  tags = {
    Name        = "primary-route53-zone"
    Environment = "prod"
  }
}

# DNS record for the EKS Cluster Endpoint
resource "aws_route53_record" "eks_endpoint" {
  zone_id = aws_route53_zone.primary_zone.zone_id
  name    = "eks.${var.domain_name}"
  type    = "CNAME"
  ttl     = 300
  records = [var.eks_endpoint]
}

# DNS record for RDS Endpoint
resource "aws_route53_record" "rds_endpoint" {
  zone_id = aws_route53_zone.primary_zone.zone_id
  name    = "rds.${var.domain_name}"
  type    = "CNAME"
  ttl     = 300
  records = [var.rds_endpoint]
}

# DNS record for RabbitMQ Host Endpoint
resource "aws_route53_record" "rabbitmq_endpoint" {
  zone_id = aws_route53_zone.primary_zone.zone_id
  name    = "rabbitmq.${var.domain_name}"
  type    = "CNAME"
  ttl     = 300
  records = [var.rabbitmq_host]
}

# DNS record for Redis Endpoint
resource "aws_route53_record" "redis_endpoint" {
  zone_id = aws_route53_zone.primary_zone.zone_id
  name    = "redis.${var.domain_name}"
  type    = "CNAME"
  ttl     = 300
  records = [var.redis_endpoint]
}

