# DevOps Store - Application Startup & Verification Guide

This guide explains how to start, verify, and demonstrate the complete DevOps Store application after restarting the laptop.

---

# 1. Start Docker Desktop

Open Docker Desktop and wait until both are green:

- Engine running
- Kubernetes running

---

# 2. Start GitHub Actions Self-Hosted Runner

Open terminal:

```bash
cd ~/devops-store/actions-runner
./run.sh

````md

# DevOps Store - CI/CD Deployment & Verification Guide

This guide explains how to deploy, verify, and demonstrate the complete DevOps Store application using GitHub Actions CI/CD and git push. **Do not use local start scripts.**

---

## 1. Prerequisites

- Docker Desktop (with Kubernetes enabled) must be running
- GitHub Actions self-hosted runner must be running (`cd actions-runner && ./run.sh`)
- Kubernetes cluster is ready (`kubectl get nodes` shows Ready)

---

## 2. Make a Code Change

Edit any file in the repository (e.g., update frontend text or README).

---

## 3. Commit and Push to GitHub

```bash
git add .
git commit -m "Your change message"
git push origin develop
```

> **Note:** The pipeline is triggered by a push to the `develop` branch. Adjust if your pipeline uses a different branch.

---

## 4. Monitor GitHub Actions Pipeline

1. Go to your repository on GitHub.
2. Click on the **Actions** tab.
3. Watch the workflow for your push:
    - **Builds Docker images** for all services
    - **Pushes images** to Docker Hub
    - **Applies Terraform** to manage infrastructure
    - **Deploys/updates Kubernetes** resources

All steps should complete successfully.

---

## 5. Verify Kubernetes Deployments

After the pipeline completes:

```bash
kubectl get pods
```

All pods for these services should be `Running`:

- frontend
- api-gateway
- product-service
- user-service
- order-service
- discovery-service
- database pods

---

## 6. Verify Services and Endpoints

Check NodePorts:

```bash
kubectl get svc
```

| Service         | Port  |
| --------------- | ----- |
| frontend        | 30000 |
| api-gateway     | 30080 |
| product-service | 30081 |
| user-service    | 30082 |
| order-service   | 30083 |

---

## 7. Access the Application

Open your browser:

```
http://localhost:30000
```

You should see the DevOps Store frontend.

---


## 8. Verify Backend APIs

Test endpoints (after pipeline deploy):

```bash
curl http://localhost:30081/api/products
curl http://localhost:30082/api/users
curl http://localhost:30083/api/orders
```

---

## 9. (Optional) Re-populate Demo Products

> **Note:** Data is not persisted between deployments. Run these commands after every deployment to add demo products.

Add iPhone 15:
```bash
curl -X POST http://localhost:30081/api/products \
    -H "Content-Type: application/json" \
    -d '{
        "name": "iPhone 15",
        "description": "Apple flagship smartphone",
        "price": 79999
    }'
```

Add MacBook Air M3:
```bash
curl -X POST http://localhost:30081/api/products \
    -H "Content-Type: application/json" \
    -d '{
        "name": "MacBook Air M3",
        "description": "Apple lightweight laptop",
        "price": 129999
    }'
```

Add Samsung Galaxy S24:
```bash
curl -X POST http://localhost:30081/api/products \
    -H "Content-Type: application/json" \
    -d '{
        "name": "Samsung Galaxy S24",
        "description": "Samsung premium smartphone",
        "price": 69999
    }'
```

---

## 10. Demo Flow (UI)

1. **Register a user:**
    - Go to `/register` and create a new account
2. **Login:**
    - Go to `/login` and sign in
3. **Browse products:**
    - Go to `/products` and verify products are listed
4. **Add to cart and checkout:**
    - Add products to cart, go to `/cart`, and checkout
    - Expect "Order placed successfully!" popup

---

## 10. Verify Orders (API)

```bash
curl http://localhost:30083/api/orders
```

You should see recent orders in the response.

---

## 11. Observe Rolling Updates

When you push a new change, the pipeline will trigger a rolling update:

```bash
kubectl get pods -w
```

Watch pods terminate and new ones start automatically.

---

## 12. Troubleshooting

- View pods: `kubectl get pods`
- View services: `kubectl get svc`
- View logs: `kubectl logs deployment/<service-name>`
- Restart deployment: `kubectl rollout restart deployment <service-name>`

---

## 13. Architecture Overview

```
GitHub Actions (CI/CD)
   ↓
Docker Build & Push
   ↓
Terraform Infra Provision
   ↓
Kubernetes Deployments
   ↓
DevOps Store (Microservices + Frontend)
```

---

## 14. Tech Stack

| Technology       | Purpose                  |
| ---------------- | ------------------------ |
| React            | Frontend UI              |
| Spring Boot      | Backend microservices    |
| PostgreSQL       | Databases                |
| Docker           | Containerization         |
| Kubernetes       | Container orchestration  |
| Terraform        | Infrastructure as Code   |
| GitHub Actions   | CI/CD automation         |
| Docker Hub       | Container image registry |
| Kind             | Local Kubernetes cluster |
| NGINX            | Frontend serving         |
| API Gateway      | Routing requests         |
| Eureka Discovery | Service discovery        |

---

## 15. Demo Checklist

- [ ] Pipeline triggers on git push
- [ ] All pods running after deploy
- [ ] Frontend accessible
- [ ] Backend APIs working
- [ ] User registration/login works
- [ ] Product listing and order flow works
- [ ] Rolling updates observed

---
```
