#!/bin/bash
# Terminate EC2 instance safely
# Usage: ./terminate-ec2.sh <instance-id>
# Author: Shashi - DevOps Learning 2026

set -e

INSTANCE_ID=$1

# Check if instance ID was provided
if [ -z "$INSTANCE_ID" ]; then
  echo "ERROR: Please provide instance ID"
  echo "Usage: ./terminate-ec2.sh i-1234567890abcdef0"
  exit 1
fi

echo "Terminating instance: $INSTANCE_ID"
aws ec2 terminate-instances --instance-ids $INSTANCE_ID

echo "Waiting for termination..."
aws ec2 wait instance-terminated --instance-ids $INSTANCE_ID

echo "Instance $INSTANCE_ID terminated successfully"