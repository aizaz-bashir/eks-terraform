# Variables for PostgreSQL Credentials
variable "postgres_username" {
  description = "Username for PostgreSQL"
  type        = string
}

variable "postgres_password" {
  description = "Password for PostgreSQL"
  type        = string
}
variable "vpc_id" {}
variable "private_subnets" {}