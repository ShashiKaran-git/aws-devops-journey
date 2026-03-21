#!/bin/bash
# Script to launch an EC2 instance
# Author: Shashi
# Date: 2026

INSTANCE_TYPE="t3.micro"
REGION="ap-south-1"
AMI_ID="ami-0f58b397bc5c1f2e8"
KEY_NAME="my-first-key"

echo "Launching EC2 instance..."
INSTANCE_ID=$(aws ec2 run-instances \
  --image-id $AMI_ID \
  --instance-type $INSTANCE_TYPE \
  --key-name $KEY_NAME \
  --region $REGION \
  --query 'Instances[0].InstanceId' \
  --output text)

echo "Instance launched: $INSTANCE_ID"
echo "Waiting for instance to start..."
aws ec2 wait instance-running --instance-ids $INSTANCE_ID
echo "Instance is running!"