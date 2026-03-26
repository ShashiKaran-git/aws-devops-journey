# AWS DevOps Learning

Personal AWS learning journey - hands-on projects and scripts.

## What I built

### EC2
- Launched and connected to EC2 instance via SSH
- Understood AMI, instance types, key pairs, security groups
- Terminated instances properly to avoid billing

### IAM
- Secured root account with MFA
- Created IAM user with least privilege
- Configured AWS CLI with access keys

### S3
- Created S3 bucket via CLI
- Uploaded and downloaded files
- Hosted static website on S3
- Configured bucket policies for public access

### VPC
- Understood VPC components — subnets, internet gateway, route tables
- Explored default VPC using CLI
- Built complete custom VPC from scratch
- Created public subnet with internet access
- Configured route table and internet gateway
- Automated entire VPC setup with bash script

## Scripts
- `scripts/launch-ec2.sh` - Launch EC2 instance from CLI
- `scripts/s3-setup.sh` - Create and configure S3 bucket
- `scripts/vpc-setup.sh` - Build complete VPC with public subnet

## Tools Used
- AWS CLI
- Git Bash
- AWS Console

## Kubernetes
* Understood Pods, Deployments, ReplicaSets and how they relate
* Watched reconciliation loop live — deleted a pod, saw Kubernetes replace it automatically
* Learned RollingUpdate vs Recreate vs Canary deployment strategies
* Created a Service and exposed nginx app via NodePort
* Accessed live app in browser via minikube

## Roadmap
- [x] EC2
- [x] IAM
- [x] S3
- [x] VPC
- [ ] EKS
- [ ] Kubernetes
- [ ] Terraform
- [ ] DevSecOps tools

## Author
Shashi Karan 

