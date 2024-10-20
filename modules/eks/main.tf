# Create an EKS Cluster using the Terraform AWS EKS module
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.24.3"

  cluster_name    = "my-eks-cluster"
  cluster_version = "1.25"
  vpc_id          = var.vpc_id
  subnet_ids      = var.subnet_ids
  enable_irsa = true

  cluster_endpoint_private_access = false
  cluster_endpoint_public_access  = true

  cluster_security_group_id = var.eks_security_group_id

  iam_role_arn = var.cluster_iam_role_name


  eks_managed_node_groups = {
    eks_nodes = {
      desired_capacity = 2
      max_capacity     = 3
      min_capacity     = 1

      instance_types = ["t3.medium"]

      ssh_key_name = "eks-keypair"

      node_group_name = "eks-nodes"

      subnet_ids = var.subnet_ids

      iam_role_arn = var.eks_node_role_arn


      tags = {
        Name = "eks-node-group"
      }

      remote_access_security_group_id = var.eks_security_group_id

    }
  }

  tags = {
    Name        = "my-eks-cluster"
    Environment = "prod"
    Terraform   = "true"
  }
}
