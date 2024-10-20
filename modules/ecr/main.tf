resource "aws_ecr_repository" "backend_repo" {
  name                 = "${var.project_name}-backend"
  image_tag_mutability = "MUTABLE"

  tags = {
    Name        = "${var.project_name}-backend"
    Environment = "production"
  }
}

resource "aws_ecr_repository" "strategy_repo" {
  name                 = "${var.project_name}-strategy"
  image_tag_mutability = "MUTABLE"

  tags = {
    Name        = "${var.project_name}-strategy"
    Environment = "production"
  }
}

resource "aws_ecr_repository" "executor_repo" {
  name                 = "${var.project_name}-executor"
  image_tag_mutability = "MUTABLE"

  tags = {
    Name        = "${var.project_name}-executor"
    Environment = "production"
  }
}


