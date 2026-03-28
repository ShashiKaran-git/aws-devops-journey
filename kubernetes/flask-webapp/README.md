# Flask Webapp Kubernetes Deployment

A production-grade Python Flask application deployed on Kubernetes.

## What This Project Demonstrates
- Containerizing a Python Flask app with Docker
- Kubernetes Deployment with 3 replicas and RollingUpdate strategy
- ConfigMaps for application configuration
- Secrets management for sensitive data
- Liveness and Readiness probes for health checking
- NodePort Service with load balancing across replicas
- Namespace isolation for environment separation
- Resource limits for production-safe deployments

## How To Deploy

1. Create your secrets file from example:
   cp k8s/secrets.example.yaml k8s/secrets.yaml
   Edit secrets.yaml with your base64 encoded values

2. Apply all manifests in order:
   kubectl apply -f k8s/namespace.yaml
   kubectl apply -f k8s/configmap.yaml
   kubectl apply -f k8s/secrets.yaml
   kubectl apply -f k8s/deployment.yaml
   kubectl apply -f k8s/service.yaml

3. Access the app:
   minikube service flask-webapp -n flask-app --url

## Live Load Balancing
Refresh the app URL multiple times and watch pod_name 
change between 3 replicas proving live load balancing.

## Docker Image
docker pull shashikarandev/flask-webapp:v1

## Tech Stack
- Python Flask
- Docker
- Kubernetes
- Minikube
