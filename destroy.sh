#!/bin/bash

set -e

echo "🔥 Destroying infrastructure..."

terraform -chdir=terraform/k8s-resources destroy -auto-approve

echo "🗑️ Deleting Kind cluster..."
kind delete cluster --name devops-store

echo "✅ Cleanup complete"