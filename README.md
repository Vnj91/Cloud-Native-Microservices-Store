# Cloud Native Microservices Store

A fully automated cloud-native microservices application built using:

- Spring Boot Microservices
- Docker
- Kubernetes (Kind)
- Terraform
- GitHub Actions CI/CD
- Self-hosted GitHub Runner
- PostgreSQL
- API Gateway
- Eureka Service Discovery

---

# Architecture


A[Frontend] --> B[API Gateway]

B --> C[User Service]
B --> D[Product Service]
B --> E[Order Service]

C --> F[(User DB)]
D --> G[(Product DB)]
E --> H[(Order DB)]

C --> I[Eureka Discovery]
D --> I
E --> I
B --> I
```

---

# Tech Stack

| Technology | Purpose |
|---|---|
| Spring Boot | Microservices |
| Docker | Containerization |
| Kubernetes | Container Orchestration |
| Terraform | Infrastructure as Code |
| GitHub Actions | CI/CD Pipeline |
| Kind | Local Kubernetes Cluster |
| PostgreSQL | Databases |
| Eureka | Service Discovery |
| API Gateway | Request Routing |

---

# Project Structure

```bash
.
├── .github/workflows
├── services
│   ├── api-gateway
│   ├── discovery-service
│   ├── frontend
│   ├── order-service
│   ├── product-service
│   └── user-service
├── terraform
│   └── k8s-resources
├── deploy.sh
├── destroy.sh
└── kind-config.yaml
```

---

# Prerequisites

Install the following tools:

- Docker
- kubectl
- Kind
- Terraform
- Git
- Java 17+
- Maven

---

# Clone Repository

```bash
git clone https://github.com/Vnj91/Cloud-Native-Microservices-Store.git

cd Cloud-Native-Microservices-Store
```

---

# Create Kind Cluster

```bash
kind create cluster --name devops-store --config kind-config.yaml
```

---

# Configure Terraform Variables

Create:

```bash
terraform/k8s-resources/terraform.tfvars
```

Example:

```hcl
docker_hub_username = "your-dockerhub-username"

user_db_username = "postgres"
user_db_password = "postgres"

product_db_username = "postgres"
product_db_password = "postgres"
```

---

# Deploy Application

Run:

```bash
chmod +x deploy.sh

./deploy.sh
```

---

# Verify Deployment

Check pods:

```bash
kubectl get pods
```

Check services:

```bash
kubectl get svc
```

---

# Application URLs

| Service | URL |
|---|---|
| Frontend | http://localhost:30000 |
| API Gateway | http://localhost:30080 |
| Product Service | http://localhost:30081 |
| User Service | http://localhost:30082 |
| Order Service | http://localhost:30083 |

---

# CI/CD Pipeline

The project uses GitHub Actions with a self-hosted runner.

Pipeline Flow:

```text
Git Push
   ↓
GitHub Actions
   ↓
Docker Build + Push
   ↓
Terraform Deployment
   ↓
Kubernetes Deployment
   ↓
Application Live
```

---

# Destroy Infrastructure

To clean up the entire deployment:

```bash
chmod +x destroy.sh

./destroy.sh
```

-----

# Features

- Fully containerized microservices
- Automated CI/CD pipeline
- Infrastructure as Code using Terraform
- Self-hosted GitHub Actions runner
- Kubernetes orchestration
- API Gateway routing
- Service discovery using Eureka
- Persistent PostgreSQL databases
- Automated deployment scripts

---

# Future Improvements

- Prometheus Monitoring
- Grafana Dashboards
- Kubernetes Ingress
- HTTPS/TLS
- Cloud Deployment (AWS/GCP/Azure)
- Helm Charts
- Horizontal Pod Autoscaling

---

# Author

Vanshaj Srivastava
