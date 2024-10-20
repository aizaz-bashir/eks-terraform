# Secrets Manager Policy Document
data "aws_iam_policy_document" "secrets_manager_policy" {
  statement {
    actions   = ["secretsmanager:GetSecretValue"]
    resources = [var.db_credentials_arn]
  }
}

resource "aws_iam_policy" "secrets_manager_policy" {
  name   = "secrets_manager_access"
  policy = data.aws_iam_policy_document.secrets_manager_policy.json
}

# IAM Role for IRSA - Access Secrets Manager
resource "aws_iam_role" "eks_secrets_role" {
  name               = "eks_secrets_access_role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    effect = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]
    principals {
      type        = "Federated"
      identifiers = [var.oidc_provider_arn]
    }
    condition {
      test     = "StringEquals"
      variable = "${replace(var.oidc_provider_url, "https://", "")}:sub"
      values   = ["system:serviceaccount:${var.kubernetes_namespace}:${var.kubernetes_service_account}"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "attach_secrets_policy" {
  role       = aws_iam_role.eks_secrets_role.name
  policy_arn = aws_iam_policy.secrets_manager_policy.arn
}


output "secrets_role_arn" {
  value = aws_iam_role.eks_secrets_role.arn
}
