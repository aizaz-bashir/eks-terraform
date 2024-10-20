variable "db_credentials_arn" {
  description = "ARN of the Secrets Manager secret for the database credentials"
  type        = string
}

variable "oidc_provider_arn" {
  description = "ARN of the OIDC provider"
  type        = string
}

variable "oidc_provider_url" {
  description = "URL of the OIDC provider"
  type        = string
}

variable "kubernetes_namespace" {
  description = "Namespace of the Kubernetes service account"
  type        = string
}

variable "kubernetes_service_account" {
  description = "Name of the Kubernetes service account"
  type        = string
}
