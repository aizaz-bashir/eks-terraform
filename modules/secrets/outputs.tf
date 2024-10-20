output "db_credentials_arn" {
  value = aws_secretsmanager_secret.postgres_secret.arn
}

output "postgres_username" {
  value = jsondecode(aws_secretsmanager_secret_version.postgres_credentials_version.secret_string).username
}

output "postgres_password" {
  value = jsondecode(aws_secretsmanager_secret_version.postgres_credentials_version.secret_string).password
}

output "rabbitmq_username" {
  value = jsondecode(aws_secretsmanager_secret_version.rabbitmq_credentials_version.secret_string).username
}

output "rabbitmq_password" {
  value = jsondecode(aws_secretsmanager_secret_version.rabbitmq_credentials_version.secret_string).password
}

output "postgres_secret_arn" {
  value = aws_secretsmanager_secret.postgres_secret.arn
}

output "rabbitmq_secret_arn" {
  value = aws_secretsmanager_secret.rabbitmq_secret.arn
}
