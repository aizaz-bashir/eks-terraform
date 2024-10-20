variable "account_id" {
  description = "AWS account ID"
  type        = string
}

variable "admin_user" {
  description = "IAM user for Kubernetes admin access"
  type        = string
}

variable "region" {
  description = "your aws region"
  type = string
}

variable "cluster_name" {
  type = string
}

variable "kubernetes_namespace" {
  type = string
}

variable "kubernetes_service_account" {
  type = string
}
# Variables for RabbitMQ Credentials
variable "rabbitmq_username" {
  description = "Username for RabbitMQ"
  type        = string
}

variable "rabbitmq_password" {
  description = "Password for RabbitMQ"
  type        = string
}
# Variables for PostgreSQL Credentials
variable "postgres_username" {
  description = "Username for PostgreSQL"
  type        = string
}

variable "postgres_password" {
  description = "Password for PostgreSQL"
  type        = string
}


variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "The list of availability zones to be used in the deployment"
  type        = list(string)
  default     = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
}

variable "public_subnets" {
  description = "The list of public subnets for the VPC"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

variable "private_subnets" {
  description = "The list of private subnets for the VPC"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "principal_arn" {
  description = "Principal user arn"
  type        = string

}
variable "postgres_host" {
  description = "PostgreSQL host"
  type        = string
}

variable "postgres_port" {
  description = "PostgreSQL port"
  type        = number
  default     = 5432  # You can change the default if needed
}

variable "postgres_database" {
  description = "PostgreSQL database name"
  type        = string
}

variable "domain_name" {
  description = "The domain name for Route 53"
  type        = string
}

variable "project_name" {
  description = " Project name for your ECR repository"
  type = string
}