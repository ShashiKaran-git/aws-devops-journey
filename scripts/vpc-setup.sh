#!/bin/bash
# VPC Setup Script
# Creates a complete VPC with public subnet
# Author: Shashi - DevOps Learning 2026

# Create VPC
VPC_ID=$(aws ec2 create-vpc --cidr-block 10.0.0.0/16 --query 'Vpc.VpcId' --output text)
echo "VPC created: $VPC_ID"

# Create Subnet
SUBNET_ID=$(aws ec2 create-subnet --vpc-id $VPC_ID --cidr-block 10.0.1.0/24 --availability-zone ap-south-1a --query 'Subnet.SubnetId' --output text)
echo "Subnet created: $SUBNET_ID"

# Create Internet Gateway
IGW_ID=$(aws ec2 create-internet-gateway --query 'InternetGateway.InternetGatewayId' --output text)
echo "Internet Gateway created: $IGW_ID"

# Attach Gateway to VPC
aws ec2 attach-internet-gateway --internet-gateway-id $IGW_ID --vpc-id $VPC_ID
echo "Gateway attached to VPC"

# Create Route Table
RTB_ID=$(aws ec2 create-route-table --vpc-id $VPC_ID --query 'RouteTable.RouteTableId' --output text)
echo "Route Table created: $RTB_ID"

# Add internet route
aws ec2 create-route --route-table-id $RTB_ID --destination-cidr-block 0.0.0.0/0 --gateway-id $IGW_ID
echo "Internet route added"

# Associate route table with subnet
aws ec2 associate-route-table --route-table-id $RTB_ID --subnet-id $SUBNET_ID
echo "Route table associated with subnet"

# Enable public IP
aws ec2 modify-subnet-attribute --subnet-id $SUBNET_ID --map-public-ip-on-launch
echo "Public IP enabled"

echo "================================"
echo "VPC Setup Complete!"
echo "VPC ID: $VPC_ID"
echo "Subnet ID: $SUBNET_ID"
echo "Internet Gateway ID: $IGW_ID"
echo "Route Table ID: $RTB_ID"
echo "================================"
