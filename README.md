## 🌐 Particle41 DevOps Challenge - SimpleTimeService 🚀

#### This guide provides detailed instructions for deploying a **FastAPI-based microservice** on **Google Kubernetes Engine (GKE)** 🛠️. Deployment is automated using **Terraform** 🏗️ and **GitHub Actions** 🤖, ensuring a streamlined CI/CD process.

---

## 📂 Project Directory Overview

```
├── .github/
│   └── workflows/
│       ├── gke-provisioning.yaml       # 🛠️ Workflow for provisioning GKE cluster using Terraform
│       └── app-deployment.yaml         # 🚀 Workflow for deploying the FastAPI app
├── manifests/
│   ├── deployment.yaml                 # 📦 Kubernetes Deployment for the FastAPI app
│   ├── service.yaml                     # 🌐 Kubernetes Service to expose the app
├── terraform/
│   ├── main.tf                         # 🏗️ Main Terraform configuration for GKE                       
│   ├── variables.tf                    # 📋 Terraform variables
│   ├── terraform.tfvars                # 📝 Variable values (excluding secrets)
│   ├── backend.tf                      # 🗂️ Backend configuration for state management
│   └── outputs.tf                      # 🔄 Outputs from the Terraform setup
├── app/
│   ├── main.py                         # 🚀 FastAPI service returning timestamp & client IP
│   ├── requirements.txt                 # 📦 Python dependencies
│   ├── Dockerfile                       # 🐳 Dockerfile for containerization
└── README.md                            # 📘 This file
```

---

## 🚀 Deployment Process

### 1️⃣ Provision GKE Cluster with Terraform 🏗️

Terraform 🛠️ provisions the necessary infrastructure on **Google Cloud** ☁️, including:

- **GKE Cluster** 🏗️: Hosts the **SimpleTimeService** API.
- **Networking** 🌐: Configures the VPC with **2 public & 2 private subnets**.
- **NAT Gateway** 🔄: Allows private nodes to access the internet.

#### 📝 Terraform Configuration Files:

- `main.tf` → Core configuration for **Google Kubernetes**
- `outputs.tf` → Exposes **GKE cluster details** post-provisioning

#### ✅ Run the Terraform provisioning via **GitHub Actions (gke-provisioning.yaml)**

This workflow automates the following steps:

```bash
terraform init
terraform plan
terraform apply -auto-approve
```

---

### 2️⃣ Build and Deploy the FastAPI App 🚀

Once the **GKE cluster is provisioned**, deploy the **SimpleTimeService API** 📦.

#### 🌐 Web App Configuration:

- **FastAPI Service** → Returns JSON response with current timestamp & client IP.
- **Dockerfile 🐳** → Builds a containerized app running as a **non-root user**.
- **Kubernetes Manifests 📋**:
  - `deployment.yaml` → Deploys the FastAPI app on **GKE**
  - `service.yaml` → Exposes the app using **LoadBalancer**

#### ✅ Deployment is handled via **GitHub Actions (app-deployment.yaml)**:

1. 🐳 **Builds Docker image**
2. 📤 **Pushes image to Google Artifact Registry (GAR)**
3. 📋 **Applies Kubernetes manifests using `kubectl apply`**

---

## 🤖 CI/CD Automation with GitHub Actions

### 🔹 **gke-provisioning.yaml**
- Automates Terraform 🏗️ provisioning of the **GKE cluster**
- Runs on **pushes to the main branch** or manual triggers

### 🔹 **app-deployment.yaml**
- 🐳 **Builds and pushes Docker image to Google Artifact Registry (GAR)**
- 📋 **Deploys the FastAPI app to GKE using `kubectl apply`**
- Executes on **updates to application code or Kubernetes manifests** 📋

---

## 🔄 Continuous Deployment & Monitoring

### ✅ **Automated Deployment Process**
- Any changes pushed to **GitHub** 📤 trigger an **automated deployment**.
- Terraform manages **infrastructure updates**, keeping it in sync.
- **Kubernetes ensures** that the FastAPI app runs efficiently.

---

## 📝 Summary

### This project demonstrates:

✅ **Automated Infrastructure as Code (IaC) with Terraform** 🏗️  
✅ **Scalable Deployment with Kubernetes (GKE)** 🌐  
✅ **Secure CI/CD Automation using GitHub Actions** 🤖  
✅ **Optimized Docker-based microservice architecture** 🐳  

By following this guide, you can **deploy, monitor, and manage** a fully automated **FastAPI microservice on GKE** ☁️. 🚀

---
