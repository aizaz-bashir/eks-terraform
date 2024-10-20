variable "postgres_username" {
  description = "PostgreSQL database username"
  type        = string
}

variable "postgres_password" {
  description = "PostgreSQL database password"
  type        = string
  sensitive   = true
}

variable "postgres_host" {
  description = "PostgreSQL database host"
  type        = string
  default = "your_db_host"
}

variable "postgres_port" {
  description = "PostgreSQL database port"
  type        = string
  default     = "5432"
}

variable "postgres_database" {
  description = "PostgreSQL database name"
  type        = string
}

variable "rabbitmq_username" {
  description = "RabbitMQ username"
  type        = string
}

variable "rabbitmq_password" {
  description = "RabbitMQ password"
  type        = string
  sensitive   = true
}
