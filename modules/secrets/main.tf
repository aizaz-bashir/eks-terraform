# PostgreSQL Database Secret
resource "aws_secretsmanager_secret" "postgres_secret" {
  name        = "prod/db/postgres"
  description = "PostgreSQL database credentials"
}

resource "aws_secretsmanager_secret_version" "postgres_credentials_version" {
  secret_id     = aws_secretsmanager_secret.postgres_secret.id
  secret_string = jsonencode({
    username = var.postgres_username
    password = var.postgres_password
    host     = var.postgres_host
    port     = var.postgres_port
    database = var.postgres_database
  })
}

# RabbitMQ Secret
resource "aws_secretsmanager_secret" "rabbitmq_secret" {
  name        = "prod/rabbitmq/credentials"
  description = "RabbitMQ credentials"
}

resource "aws_secretsmanager_secret_version" "rabbitmq_credentials_version" {
  secret_id     = aws_secretsmanager_secret.rabbitmq_secret.id
  secret_string = jsonencode({
    username = var.rabbitmq_username
    password = var.rabbitmq_password
  })
}
