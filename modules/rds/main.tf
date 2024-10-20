# rds.tf

# Security Group for PostgreSQL
resource "aws_security_group" "postgres_sg" {
  name        = "postgres-sg"
  description = "Security group for PostgreSQL"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
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
    Name = "postgres-sg"
  }
}

# RDS Subnet Group
resource "aws_db_subnet_group" "postgres_subnet_group" {
  name       = "postgres-subnet-group"
  subnet_ids = var.private_subnets

  tags = {
    Name = "postgres-subnet-group"
  }
}

# PostgreSQL Instance
resource "aws_db_instance" "my_rds_instance" {
  identifier             = "my-postgres-db"
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "postgres"
  engine_version         = "13.11"
  instance_class         = "db.t3.micro"
  db_name                = "mydb"  # Corrected field
  username               = var.postgres_username
  password               = var.postgres_password
  parameter_group_name   = "default.postgres13"
  skip_final_snapshot    = true
  db_subnet_group_name   = aws_db_subnet_group.postgres_subnet_group.name
  vpc_security_group_ids = [aws_security_group.postgres_sg.id]
  publicly_accessible    = false

  tags = {
    Name = "postgres-db"
  }
   timeouts {
    create = "60m"
  }
}


# Optionally, store PostgreSQL credentials in AWS Secrets Manager
resource "aws_secretsmanager_secret" "postgres_credentials" {
  name        = "postgres/credentials-new"
  description = "Credentials for PostgreSQL"
}

resource "aws_secretsmanager_secret_version" "postgres_credentials_version" {
  secret_id     = aws_secretsmanager_secret.postgres_credentials.id
  secret_string = jsonencode({
    username = var.postgres_username
    password = var.postgres_password
  })
}

output "rds_endpoint" {
  value       = aws_db_instance.my_rds_instance.endpoint
  description = "The endpoint of the RDS instance."
}
