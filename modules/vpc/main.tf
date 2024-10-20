# Create a VPC using the official Terraform AWS VPC module
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.13.0"

  name = "eks-vpc"
  cidr = var.vpc_cidr
  azs             = var.availability_zones
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway = true
  single_nat_gateway = true

  # Enable DNS Support and DNS Hostnames
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name                              = "eks-vpc"
    "kubernetes.io/cluster/my-eks-cluster" = "shared"
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/my-eks-cluster" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/role/elb" = "1"
    "kubernetes.io/cluster/my-eks-cluster" = "shared"
  }
}

# Route Table for Private Subnets
resource "aws_route_table" "private_route" {
  vpc_id = module.vpc.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = module.vpc.natgw_ids[0]
  }

  tags = {
    Name = "private-route-table"
  }
}

# Associate Route Table with Private Subnets
resource "aws_route_table_association" "private_subnet_associations" {
  count          = length(module.vpc.private_subnets)
  subnet_id      = module.vpc.private_subnets[count.index]
  route_table_id = aws_route_table.private_route.id
}

# EKS Security Group
resource "aws_security_group" "eks_security_group" {
  vpc_id = module.vpc.vpc_id

  name        = "eks-security-group"
  description = "Allow EKS control plane and worker node communication"

  # Inbound rule: Allow worker node access from the control plane
  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    cidr_blocks     = [module.vpc.vpc_cidr_block]
    description     = "Allow HTTPS traffic within VPC"
  }

  # Outbound rule: Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "eks-security-group"
  }
}






