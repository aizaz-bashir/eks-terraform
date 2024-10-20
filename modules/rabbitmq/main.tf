# rabbitmq.tf

# Security Group for RabbitMQ
resource "aws_security_group" "rabbitmq_sg" {
  name        = "rabbitmq-sg"
  description = "Security group for RabbitMQ"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 5671
    to_port     = 5672
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]  # Adjust as necessary
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rabbitmq-sg"
  }
}

# RabbitMQ Broker
resource "aws_mq_broker" "rabbitmq" {
  broker_name           = "my-rabbitmq-broker"
  engine_type           = "RabbitMQ"
  engine_version        = "3.12.13"
  host_instance_type    = "mq.t3.micro"  # Corrected field
  publicly_accessible   = false
  deployment_mode       = "SINGLE_INSTANCE"
  subnet_ids            = [var.subnet_ids[0]]
  security_groups       = [aws_security_group.rabbitmq_sg.id]

  user {
    username = var.rabbitmq_username
    password = var.rabbitmq_password
  }

  logs {
    general = true
  }

  maintenance_window_start_time {
    day_of_week = "SATURDAY"
    time_of_day = "02:00"
    time_zone   = "UTC"
  }

  tags = {
    Name = "rabbitmq-broker"
  }
}



# Optionally, store RabbitMQ credentials in AWS Secrets Manager
resource "aws_secretsmanager_secret" "rabbitmq_credentials" {
  name        = "rabbitmq/credentials-new"
  description = "Credentials for RabbitMQ"
}

resource "aws_secretsmanager_secret_version" "rabbitmq_credentials_version" {
  secret_id     = aws_secretsmanager_secret.rabbitmq_credentials.id
  secret_string = jsonencode({
    username = var.rabbitmq_username
    password = var.rabbitmq_password
  })
}

output "rabbitmq_endpoint" {
  value = aws_mq_broker.rabbitmq.instances[0].endpoints[0]
  description = "The endpoint of the RabbitMQ broker."
}
