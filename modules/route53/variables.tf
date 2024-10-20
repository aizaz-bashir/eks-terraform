variable "domain_name" {
  description = "The domain name for the Route 53 hosted zone"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID for which the hosted zone will be associated"
  type        = string
}

variable "eks_endpoint" {
  description = "The endpoint of the EKS cluster"
  type        = string
}

variable "rds_endpoint" {
  description = "The endpoint of the RDS instance"
  type        = string
}

variable "rabbitmq_host" {
  description = "The endpoint of the RabbitMQ broker"
  type        = string
}

variable "redis_endpoint" {
  description = "The endpoint of the Redis instance"
  type        = string
}
