#!/bin/bash
# EC2 Launch Script - Production Ready
# Usage: ./launch-ec2.sh [instance-type] [region]
# Example: ./launch-ec2.sh t3.micro ap-south-1
# Author: Shashi - DevOps Learning 2026

# Exit immediately if any command fails
set -e

# Parameters with defaults
# If you don't pass arguments, it uses these defaults
INSTANCE_TYPE=${1:-t3.micro}
REGION=${2:-ap-south-1}
AMI_ID="ami-0f58b397bc5c1f2e8"
KEY_NAME="my-first-key"

# Validate key pair exists before launching
# If key doesn't exist, exit with error message
aws ec2 describe-key-pairs \
  --key-names $KEY_NAME \
  --region $REGION > /dev/null 2>&1 || {
    echo "ERROR: Key pair $KEY_NAME not found in $REGION"
    exit 1
}

echo "Launching $INSTANCE_TYPE in $REGION..."

# Launch instance and capture ID
INSTANCE_ID=$(aws ec2 run-instances \
  --image-id $AMI_ID \
  --instance-type $INSTANCE_TYPE \
  --key-name $KEY_NAME \
  --region $REGION \
  --tag-specifications \
  'ResourceType=instance,Tags=[{Key=Author,Value=Shashi},{Key=Project,Value=DevOps-Journey}]' \
  --query 'Instances[0].InstanceId' \
  --output text)

echo "Instance launched: $INSTANCE_ID"
echo "Waiting for running state..."

# Wait until instance is running
aws ec2 wait instance-running \
  --instance-ids $INSTANCE_ID \
  --region $REGION

# Get public IP
PUBLIC_IP=$(aws ec2 describe-instances \
  --instance-ids $INSTANCE_ID \
  --query 'Reservations[0].Instances[0].PublicIpAddress' \
  --output text \
  --region $REGION)

echo "Instance is running!"
echo "Public IP: $PUBLIC_IP"
echo "SSH command: ssh -i $KEY_NAME.pem ec2-user@$PUBLIC_IP"
echo "Remember to terminate: aws ec2 terminate-instances --instance-ids $INSTANCE_ID"