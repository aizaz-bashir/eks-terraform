# oidc.tf

resource "aws_iam_openid_connect_provider" "oidc_provider" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.oidc_thumbprint.certificates[0].sha1_fingerprint]
  url             = var.cluster_oidc_issuer_url
}
resource "aws_eks_identity_provider_config" "oidc" {
  cluster_name                  = var.cluster_name
  oidc {
    identity_provider_config_name = "cognito-oidc-provider"
    issuer_url                    = var.cluster_oidc_issuer_url
    client_id                     = var.client_id
    username_claim                = "sub"
    groups_claim                  = "cognito:groups"
    groups_prefix                 = "cognito:"
  }

}


data "tls_certificate" "oidc_thumbprint" {
  url = var.cluster_oidc_issuer_url
}

output "oidc_provider_url" {
  value = var.cluster_oidc_issuer_url
}
output "oidc_provider_arn" {
  value = aws_iam_openid_connect_provider.oidc_provider.arn
}



