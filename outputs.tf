output "cluster_oidc_issuer_url" {
  description = "The URL on the EKS cluster OIDC Issuer"
  value       = module.eks.cluster_oidc_issuer_url
}

output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "eks_cluster_certificate_authority_data" {
  value = module.eks.cluster_certificate_authority_data
}
output "cluster_name" {
  value = module.eks.cluster_name
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "eks_security_group_id" {
  value = module.vpc.eks_security_group_id
}

output "postgres_username" {
  value = module.secrets.postgres_username
  sensitive = true
}

output "postgres_password" {
  value = module.secrets.postgres_password
  sensitive = true
}

output "rabbitmq_username" {
  value = module.secrets.rabbitmq_username
  sensitive = true
}

output "rabbitmq_password" {
  value = module.secrets.rabbitmq_password
  sensitive = true
}
output "db_credentials_arn" {
  value = module.secrets.db_credentials_arn
}
output "oidc_provider_arn" {
  value = module.oidc.oidc_provider_arn
}

output "oidc_provider_url" {
  value = module.oidc.oidc_provider_url
}

output "postgres_secret_arn" {
  value       = module.secrets.postgres_secret_arn
  description = "ARN of the PostgreSQL secret"
}

output "rabbitmq_secret_arn" {
  value       = module.secrets.rabbitmq_secret_arn
  description = "ARN of the RabbitMQ secret"
}
output "secrets_role_arn" {
  value = module.iam_irsa.secrets_role_arn
}


output "client_id" {
  value = module.cognito.oidc_user_pool_client_id
}

# Outputs for Route 53
output "route53_zone_id" {
  value = module.route53.zone_id
}

output "route53_domain_name" {
  value = module.route53.domain_name
}

output "backend_repo_url" {
  value = module.ecr.backend_repo_url
}

output "strategy_repo_url" {
  value = module.ecr.strategy_repo_url
}

output "executor_repo_url" {
  value = module.ecr.executor_repo_url
}