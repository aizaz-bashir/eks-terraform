# Cognito User Pool
resource "aws_cognito_user_pool" "oidc_user_pool" {
  name = "example-oidc-user-pool"
}

# Cognito User Pool Client
resource "aws_cognito_user_pool_client" "oidc_user_pool_client" {
  name         = "example-oidc-client"
  user_pool_id = aws_cognito_user_pool.oidc_user_pool.id

  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows                  = ["code"]
  allowed_oauth_scopes                 = ["openid", "email", "profile"]
  supported_identity_providers         = ["COGNITO"]

  callback_urls = ["https://example.com/callback"]  # Replace with your actual callback URL
}

# Associate Cognito OIDC with EKS
resource "aws_eks_identity_provider_config" "oidc" {
  provider     = aws
  cluster_name = var.cluster_name

  oidc {
    identity_provider_config_name = "cognito-oidc-provider"
    issuer_url     = var.cluster_oidc_issuer_url
    client_id      = aws_cognito_user_pool_client.oidc_user_pool_client.id
    username_claim = "sub"
    username_prefix = "cognito:"
    groups_claim    = "cognito:groups"
    groups_prefix   = "cognito:"
  }

  depends_on = [
    aws_cognito_user_pool.oidc_user_pool,
    aws_cognito_user_pool_client.oidc_user_pool_client
  ]
}
output "client_id" {
  value = aws_cognito_user_pool_client.oidc_user_pool_client.id
}
output "oidc_user_pool_client_id" {
  description = "The client ID for the OIDC user pool"
  value       = aws_cognito_user_pool_client.oidc_user_pool_client.id
}
