# AWS Provider
provider "aws" {
  region = var.region
}
provider "kubernetes" {
  alias                  = "admin"
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args        = ["eks", "get-token", "--cluster-name", module.eks.cluster_name, "--region", var.region]
  }
}
# Fetch the EKS authentication token
data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_name
}

module "secrets" {
  source = "./modules/secrets"

  postgres_username = var.postgres_username
  postgres_password = var.postgres_password
  postgres_host     = var.postgres_host
  postgres_port     = var.postgres_port
  postgres_database = var.postgres_database
  rabbitmq_username = var.rabbitmq_username
  rabbitmq_password = var.rabbitmq_password
}

# Create a VPC using the VPC module
module "vpc" {
  source = "./modules/vpc"
  vpc_cidr             = var.vpc_cidr
  availability_zones   = var.availability_zones
  private_subnets      = var.private_subnets
  public_subnets       = var.public_subnets
  region               = var.region
  cluster_name         = var.cluster_name
}

module "eks" {
  source                = "./modules/eks"
  vpc_id                = module.vpc.vpc_id
  subnet_ids            = module.vpc.private_subnets
  eks_security_group_id = module.vpc.eks_security_group_id
  cluster_iam_role_name = module.iam_base.eks_cluster_role_arn
  eks_node_role_arn     = module.iam_base.eks_node_role_arn
}


module "oidc" {
  source = "./modules/oidc"
  cluster_oidc_issuer_url = module.eks.cluster_oidc_issuer_url
  cluster_name = module.eks.cluster_name
  client_id = module.cognito.oidc_user_pool_client_id
  depends_on = [module.eks]
}


module "iam_base" {
  source = "./modules/iam_base"
}

module "iam_irsa" {
  source = "./modules/iam_irsa"
  oidc_provider_arn = module.oidc.oidc_provider_arn
  oidc_provider_url = module.oidc.oidc_provider_url
  db_credentials_arn = module.secrets.db_credentials_arn
  kubernetes_namespace = "default"
  kubernetes_service_account = "eks-service-account"
}


module "cognito" {
  source                  = "./modules/cognito"
  cluster_oidc_issuer_url = module.eks.cluster_oidc_issuer_url
  cluster_name            = module.eks.cluster_name
}

# Access Entry Module
module "eks_access_entry" {
  source       = "./modules/eks-access-entry"
  cluster_name = module.eks.cluster_name
  principal_arn = module.iam_base.eks_node_role_arn
}



# RabbitMQ Module
module "rabbitmq" {
  source          = "./modules/rabbitmq"
  rabbitmq_username = module.secrets.rabbitmq_username
  rabbitmq_password = module.secrets.rabbitmq_password
  vpc_id           = module.vpc.vpc_id
  subnet_ids       = module.vpc.private_subnets
}

# RDS Module
module "rds" {
  source          = "./modules/rds"
  postgres_password = module.secrets.postgres_password
  postgres_username = module.secrets.postgres_username
  vpc_id           = module.vpc.vpc_id
  private_subnets  = module.vpc.private_subnets
}

# Redis Module
module "redis" {
  source         = "./modules/redis"
  vpc_id         = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
}

module "route53" {
  source = "./modules/route53"
  domain_name       = var.domain_name
  vpc_id            = module.vpc.vpc_id
  eks_endpoint      = module.eks.cluster_endpoint
  rds_endpoint      = module.rds.rds_endpoint
  rabbitmq_host     = module.rabbitmq.rabbitmq_endpoint
  redis_endpoint    = module.redis.redis_endpoint
  depends_on = [module.redis]
}

module "ecr" {
  source      = "./modules/ecr"
  project_name = var.project_name
}
