variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
}

variable "private_subnet_cidr" {
  description = "CIDR block for the private subnet"
  type        = string
}

variable "availability_zone" {
  description = "Availability zone for subnets"
  type        = string
}

variable "project_name" {
  description = "Project name used for tagging all resources"
  type        = string
}

variable "my_ip" {
  description = "Your local machine public IP for SSH access (format: x.x.x.x/32)"
  type        = string
  sensitive   = true
}