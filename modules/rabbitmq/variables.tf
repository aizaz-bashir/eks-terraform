variable "rabbitmq_username" {
  description = "Username for RabbitMQ"
  type        = string
}

variable "rabbitmq_password" {
  description = "Password for RabbitMQ"
  type        = string
}
variable "vpc_id" {}
variable "subnet_ids" {
  type        = list(string)
}
