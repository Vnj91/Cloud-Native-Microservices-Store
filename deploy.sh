#!/bin/bash

# 1. Get the latest short commit hash
export BUILD_ID=$(git rev-parse --short HEAD 2>/dev/null || echo "latest")
echo "🚀 Deploying version: $BUILD_ID"

# 2. Navigate to k8s directory
cd k8s

# 3. Apply Infrastructure (Storage)
echo "📦 Applying Storage..."
kubectl apply -f database-storage.yaml

# 4. Apply Secrets and Databases (Using specific paths)
echo "🔐 Applying Secrets and Databases..."
kubectl apply -f user/user-secret.yaml
kubectl apply -f product/product-secret.yaml
kubectl apply -f order/order-secret.yaml

kubectl apply -f user/user-db.yaml
kubectl apply -f product/product-db.yaml
kubectl apply -f order/order-db.yaml

# 5. Apply Applications with BUILD_ID injection
echo "💻 Deploying Microservices..."
envsubst < user/user-app.yaml | kubectl apply -f -
envsubst < product/product-app.yaml | kubectl apply -f -
envsubst < order/order-app.yaml | kubectl apply -f -
envsubst < gateway/gateway-app.yaml | kubectl apply -f -
envsubst < frontend/frontend-app.yaml | kubectl apply -f -

echo "✅ Deployment commands sent. Run 'kubectl get pods' to check status."