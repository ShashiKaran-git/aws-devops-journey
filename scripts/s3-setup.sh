#!/bin/bash
# Script to create and configure S3 bucket
# Author: Shashi
# Date: 2026

BUCKET_NAME="devops-learning-shashi"
REGION="ap-south-1"

echo "Creating S3 bucket..."
aws s3 mb s3://$BUCKET_NAME --region $REGION

echo "Enabling website hosting..."
aws s3 website s3://$BUCKET_NAME/ --index-document index.html

echo "Setting public access..."
aws s3api put-public-access-block \
  --bucket $BUCKET_NAME \
  --public-access-block-configuration "BlockPublicAcls=false,IgnorePublicAcls=false,BlockPublicPolicy=false,RestrictPublicBuckets=false"

echo "Done! Bucket $BUCKET_NAME is ready."