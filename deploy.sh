#!/bin/bash

set -e

echo "🚀 Starting DevOps Store deployment..."

# Create Kind cluster if it doesn't exist
if ! kind get clusters | grep -q "devops-store"; then
  echo "📦 Creating Kind cluster..."
  kind create cluster --name devops-store --config kind-config.yaml
else
  echo "✅ Kind cluster already exists"
fi

# Wait for cluster
echo "⏳ Waiting for Kubernetes cluster..."
kubectl wait --for=condition=Ready nodes --all --timeout=120s

# Terraform Init
echo "⚙️ Initializing Terraform..."
terraform -chdir=terraform/k8s-resources init

# Terraform Apply
echo "🚀 Applying Terraform infrastructure..."
terraform -chdir=terraform/k8s-resources apply -auto-approve

echo ""
echo "✅ Deployment Complete!"
echo ""

echo "🌐 Services:"
echo "Frontend        -> http://localhost:30000"
echo "API Gateway     -> http://localhost:30080"
echo "Product Service -> http://localhost:30081"
echo "User Service    -> http://localhost:30082"
echo "Order Service   -> http://localhost:30083"

echo ""
echo "📊 Pod Status:"
kubectl get pods