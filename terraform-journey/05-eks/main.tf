# ─────────────────────────────────────────
# Terraform Settings & Backend
# ─────────────────────────────────────────
terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket         = "shashi-terraform-state-2026"
    key            = "05-eks/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-state-locks"
    encrypt        = true
  }
}

# ─────────────────────────────────────────
# Provider
# ─────────────────────────────────────────
provider "aws" {
  region = var.aws_region
}

# ─────────────────────────────────────────
# Remote State — read 04-vpc outputs
# ─────────────────────────────────────────
data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "shashi-terraform-state-2026"
    key    = "04-vpc/terraform.tfstate"
    region = "ap-south-1"
  }
}

# ─────────────────────────────────────────
# Elastic IP for NAT Gateway
# ─────────────────────────────────────────
resource "aws_eip" "nat" {
  domain = "vpc"
  tags = {
    Name    = "${var.project_name}-nat-eip"
    Project = var.project_name
  }
}

# ─────────────────────────────────────────
# NAT Gateway
# ─────────────────────────────────────────
resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id     = data.terraform_remote_state.vpc.outputs.public_subnet_id
  tags = {
    Name    = "${var.project_name}-nat-gw"
    Project = var.project_name
  }
  depends_on = [aws_eip.nat]
}

# ─────────────────────────────────────────
# Private Route — send outbound traffic to NAT
# ─────────────────────────────────────────
resource "aws_route" "private_nat" {
  route_table_id         = data.terraform_remote_state.vpc.outputs.private_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.main.id
}

# ─────────────────────────────────────────
# EKS Cluster
# ─────────────────────────────────────────
resource "aws_eks_cluster" "main" {
  name     = "${var.project_name}-eks-cluster"
  role_arn = aws_iam_role.eks_cluster_role.arn
  version  = "1.29"

vpc_config {
    subnet_ids = [
      data.terraform_remote_state.vpc.outputs.public_subnet_id,
      data.terraform_remote_state.vpc.outputs.public_subnet_2_id,
      data.terraform_remote_state.vpc.outputs.private_subnet_id
    ]
    security_group_ids      = [data.terraform_remote_state.vpc.outputs.web_security_group_id]
    endpoint_private_access = true
    endpoint_public_access  = true
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy
  ]

  tags = {
    Name        = "${var.project_name}-eks-cluster"
    Environment = "dev"
    Project     = var.project_name
  }
}

# ─────────────────────────────────────────
# EKS Node Group
# ─────────────────────────────────────────
resource "aws_eks_node_group" "main" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "${var.project_name}-node-group"
  node_role_arn   = aws_iam_role.eks_node_role.arn
  subnet_ids      = [data.terraform_remote_state.vpc.outputs.private_subnet_id]

  instance_types = ["t3.medium"]

  scaling_config {
    desired_size = 2
    min_size     = 1
    max_size     = 3
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_worker_node_policy,
    aws_iam_role_policy_attachment.eks_cni_policy,
    aws_iam_role_policy_attachment.eks_ecr_policy
  ]

  tags = {
    Name        = "${var.project_name}-node-group"
    Environment = "dev"
    Project     = var.project_name
  }
}
