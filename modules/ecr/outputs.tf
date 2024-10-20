output "backend_repo_url" {
  value       = aws_ecr_repository.backend_repo.repository_url
  description = "The URL of the backend service ECR repository."
}

output "strategy_repo_url" {
  value       = aws_ecr_repository.strategy_repo.repository_url
  description = "The URL of the strategy service ECR repository."
}

output "executor_repo_url" {
  value       = aws_ecr_repository.executor_repo.repository_url
  description = "The URL of the executor service ECR repository."
}