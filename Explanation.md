# DevOps Store - Technology Stack Explanation

## Project Overview

DevOps Store is a cloud-native microservices-based e-commerce application designed to demonstrate modern DevOps, containerization, orchestration, CI/CD, infrastructure automation, and frontend/backend integration concepts.

The project was built not just as a shopping application, but as a complete DevOps showcase project demonstrating how production-grade systems are developed, containerized, deployed, automated, and managed.

---

# Architecture Overview

The application follows a microservices architecture where multiple independent services communicate together through an API Gateway and Service Discovery mechanism.

Main Components:
- Frontend Service
- API Gateway
- Product Service
- User Service
- Order Service
- Discovery Service
- PostgreSQL Databases
- Kubernetes Cluster
- CI/CD Pipeline

---

# Frontend Technologies

## React.js

### What it is
React is a JavaScript frontend library used to build dynamic and component-based user interfaces.

### Why it was used
React was chosen because:
- It supports reusable UI components
- It is widely used in production systems
- It works well with REST APIs
- It provides fast rendering through the virtual DOM
- It demonstrates frontend-backend integration skills

### Where it is used
- Product listing page
- Cart system
- Login/Register pages
- Checkout flow
- Navigation system

---

## Vite

### What it is
Vite is a modern frontend build tool and development server.

### Why it was used
- Faster than traditional React build systems
- Lightweight
- Excellent Docker compatibility
- Fast Hot Module Reloading (HMR)

---

# Backend Technologies

## Spring Boot

### What it is
Spring Boot is a Java framework used to create production-grade backend applications and REST APIs.

### Why it was used
- Industry-standard backend framework
- Excellent microservices support
- Easy REST API creation
- Strong ecosystem
- Works seamlessly with Docker and Kubernetes

### Where it is used
Each backend microservice is built using Spring Boot:
- Product Service
- User Service
- Order Service
- API Gateway
- Discovery Service

---

## Spring Cloud Gateway

### What it is
Spring Cloud Gateway acts as a reverse proxy and central entry point for all backend services.

### Why it was used
Instead of exposing every microservice directly, the gateway:
- Routes requests to correct services
- Simplifies frontend communication
- Improves scalability
- Centralizes API traffic management

### Example
Frontend requests:
```text
/api/products


Eureka Discovery Server
What it is

Eureka is a service discovery server used in microservices architectures.

Why it was used

In Kubernetes or distributed systems:

Service IPs change frequently
Hardcoding addresses is unreliable

Eureka allows services to:

Automatically register themselves
Discover other services dynamically

This demonstrates real cloud-native communication patterns.

Database Technologies
PostgreSQL
What it is

PostgreSQL is an open-source relational database system.

Why it was used
Production-grade database
Reliable and scalable
Excellent support with Spring Boot
Widely used in enterprise systems
Database Separation

Separate databases were used for:

User Service
Product Service
Order Service

This follows proper microservices principles where each service owns its own data.

Containerization
Docker
What it is

Docker is a containerization platform used to package applications and their dependencies.

Why it was used

Docker ensures:

Environment consistency
Easy deployment
Isolation between services
Scalability

Each microservice has its own Docker image.

Example Containers
Frontend Container
Product Service Container
User Service Container
PostgreSQL Containers
Container Orchestration
Kubernetes
What it is

Kubernetes is a container orchestration platform used to manage containerized applications.

Why it was used

Kubernetes provides:

Automatic deployment
Scaling
Self-healing
Load balancing
Service discovery
Rolling updates
Kubernetes Resources Used
Deployments
Services
Secrets
Persistent Volumes
Persistent Volume Claims
KIND (Kubernetes IN Docker)
What it is

KIND is a lightweight Kubernetes cluster running inside Docker.

Why it was used
Lightweight local Kubernetes environment
Perfect for development/testing
Easy integration with Docker Desktop
Infrastructure as Code
Terraform
What it is

Terraform is an Infrastructure as Code (IaC) tool used to automate infrastructure provisioning.

Why it was used

Instead of manually creating Kubernetes resources using kubectl commands, Terraform:

Automates deployments
Maintains infrastructure consistency
Supports version-controlled infrastructure
Makes deployments reproducible
Resources Managed by Terraform
Kubernetes Deployments
Services
Secrets
Persistent Storage
Monitoring Namespace
CI/CD Pipeline
GitHub Actions
What it is

GitHub Actions is a CI/CD automation platform integrated into GitHub.

Why it was used

It automates:

Docker image builds
Image pushes to Docker Hub
Kubernetes deployments
Terraform execution
Pipeline Flow
Code pushed to GitHub
Docker images built
Images pushed to Docker Hub
Terraform deploys to Kubernetes
Services become available automatically
Self-Hosted GitHub Runner
What it is

A self-hosted GitHub Actions runner executes workflows on a custom machine instead of GitHub servers.

Why it was used

GitHub-hosted runners cannot directly access the local Kubernetes cluster.

A self-hosted runner was required to:

Access local Docker Desktop Kubernetes
Run kubectl commands
Execute Terraform locally
DevOps Concepts Demonstrated
Microservices Architecture

The application is split into independent services instead of a monolith.

Benefits:

Independent scaling
Better maintainability
Fault isolation
Easier deployments
CI/CD Automation

The entire deployment process is automated from Git push to Kubernetes deployment.

Infrastructure as Code

All infrastructure is defined using Terraform instead of manual configuration.

Containerization

Every component runs inside isolated Docker containers.

Orchestration

Kubernetes manages deployment lifecycle, networking, and service communication.

Service Discovery

Eureka enables dynamic communication between microservices.

Persistent Storage

PostgreSQL databases use persistent volumes to retain data across container restarts.

Frontend Features

Implemented Features:

Product Listing
Shopping Cart
User Registration
User Login
Checkout Flow
Order Placement
Backend Features

Implemented Features:

Product APIs
User APIs
Order APIs
API Gateway Routing
Service Discovery
Database Integration
Deployment Workflow
Local Development

Services can run individually using Docker.

Production-like Deployment

The complete application stack runs on Kubernetes using:

Terraform
Docker images
GitHub Actions CI/CD
Why This Project Matters

This project demonstrates:

Full-stack development
Cloud-native architecture
DevOps automation
Kubernetes orchestration
Infrastructure as Code
CI/CD implementation
Containerized deployments
Microservices communication

It reflects many concepts used in real-world production systems and modern DevOps environments.

Future Improvements

Possible future enhancements:

JWT Authentication
Role-based access control
Prometheus Monitoring
Grafana Dashboards
Distributed Tracing
Helm Charts
ArgoCD GitOps
Horizontal Pod Autoscaling
Kafka Event Streaming
Redis Caching
NGINX Ingress Controller
Conclusion

DevOps Store is a complete cloud-native microservices project demonstrating how modern distributed applications are:

Developed
Containerized
Automated
Deployed
Orchestrated
Scaled

using modern DevOps and cloud technologies.