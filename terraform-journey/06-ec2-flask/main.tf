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
    key            = "06-ec2-flask/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-state-locks"
    encrypt        = true
  }
}
# Provider
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
# Get Latest Ubuntu 22.04 AMI
# ─────────────────────────────────────────
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical (official Ubuntu publisher)

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# ─────────────────────────────────────────
# EC2 Instance — Flask App
# ─────────────────────────────────────────
resource "aws_instance" "flask_app" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  subnet_id                   = data.terraform_remote_state.vpc.outputs.public_subnet_id
  vpc_security_group_ids      = [data.terraform_remote_state.vpc.outputs.web_security_group_id]
  associate_public_ip_address = true

  user_data = <<-EOF
    #!/bin/bash
    apt-get update -y
    apt-get install -y docker.io
    systemctl start docker
    systemctl enable docker
    docker pull shashikarandev/flask-webapp:v1
    docker run -d -p 80:5000 shashikarandev/flask-webapp:v1
  EOF

  tags = {
    Name        = "${var.project_name}-flask-app"
    Environment = "dev"
    Project     = var.project_name
  }
}
