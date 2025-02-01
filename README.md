# 🌐 Particle41 DevOps Challenge - SimpleTimeService 🚀

This guide provides detailed instructions for deploying a **FastAPI-based microservice** on **Google Kubernetes Engine (GKE)** 🛠️. Deployment is automated using **Terraform** 🏗️ and **GitHub Actions** 🤖, ensuring a streamlined CI/CD process.

## 📂 Project Directory Overview

├── .github/
│   └── workflows/
│       ├── gke-provisioning.yaml       # 🛠️ Workflow for provisioning GKE cluster using Terraform
│       └── app-deployment.yaml         # 🚀 Workflow for deploying the FastAPI app
├── manifests/
│   ├── deployment.yaml                 # 📦 Kubernetes Deployment for the FastAPI app
│   ├── service.yaml                     # 🌐 Kubernetes Service to expose the app
├── terraform/
│   ├── main.tf                         # 🏗️ Main Terraform configuration for GKE                       
│   ├── variables.tf                  # 📋 Terraform variables
│   ├── terraform.tfvars                # 📝 Variable values (excluding secrets)
│   ├── backend.tf                      # 🗂️ Backend configuration for state management
│   └── outputs.tf                      # 🔄 Outputs from the Terraform setup
├── app/
│   ├── main.py                         # 🚀 FastAPI service returning timestamp & client IP
│   ├── requirements.txt                 # 📦 Python dependencies
│   ├── Dockerfile                       # 🐳 Dockerfile for containerization
└── README.md                            # 📘 This file


## 🚀 Deployment Process

The deployment process is fully automated using GitHub Actions.  You will need a GitHub repository with the above file structure.

### Prerequisites

Before you begin, ensure you have the following:

* **Google Cloud Account:**  You'll need a Google Cloud account with billing enabled.
* **gcloud CLI:** The Google Cloud SDK command-line tool. Install and configure it: [https://cloud.google.com/sdk/docs/install](https://cloud.google.com/sdk/docs/install)
* **Terraform:** Install Terraform: [https://www.terraform.io/downloads](https://www.terraform.io/downloads)
* **kubectl:** The Kubernetes command-line tool. Install it: [https://kubernetes.io/docs/tasks/tools/install-kubectl/](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
* **GitHub Account:**  You'll need a GitHub account to host your repository and use GitHub Actions.
* **Docker:** Install Docker Desktop or Docker Engine: [https://docs.docker.com/get-docker/](https://docs.docker.com/get-docker/)

### 1️⃣ Configure Google Cloud Project

1. **Create a Project:** Create a new Google Cloud project if you don't have one.
2. **Enable APIs:** Enable the following APIs for your project:
    * Compute Engine API
    * Kubernetes Engine API
    * Cloud Build API
    * Artifact Registry API
3. **Service Account:** Create a service account with the "Project Editor" role. Download the service account key as a JSON file.  **Keep this file secure!**  This key will be used by GitHub Actions.

### 2️⃣ Configure GitHub Secrets

In your GitHub repository, go to *Settings* -> *Secrets and variables* -> *Actions*. Add the following secrets:

* `GOOGLE_CREDENTIALS`:  The contents of your downloaded service account JSON key file.
* `PROJECT_ID`: Your Google Cloud project ID.
* `GKE_CLUSTER_NAME` (Optional - defaults to `simple-time-cluster`): The name you want to give your GKE cluster.
* `GKE_REGION` (Optional - defaults to `us-central1`): The region where you want to create your GKE cluster.

### 3️⃣ Deploy

1. **Clone the Repository:** Clone this repository to your local machine.
2. **Configure Terraform Variables:** In the `terraform/terraform.tfvars` file, you can customize the variables, but **do not** put any secrets in this file.
3. **Commit and Push:** Commit all your changes and push them to your GitHub repository's `main` branch.

### 4️⃣ GitHub Actions will handle the rest!

The `gke-provisioning.yaml` workflow will:

* Initialize Terraform.
* Plan the infrastructure changes.
* Apply the changes, creating the GKE cluster.

The `app-deployment.yaml` workflow will then:

* Build the Docker image.
* Push the image to Google Artifact Registry.
* Deploy the application to the GKE cluster using `kubectl apply`.

### 5️⃣ Access the Application

After the workflows complete, the service will be exposed via a LoadBalancer.  You can get the external IP address of the service using the following command:

```bash
kubectl get service simple-time-service -n simple-time-ns
Replace simple-time-service and simple-time-ns with the actual service name and namespace if you customized them in the manifests.  The output will show the EXTERNAL-IP.  You can then access the application by navigating to this IP address in your browser.

🤖 CI/CD Automation with GitHub Actions
See the comments in the .github/workflows directory's YAML files for details on each step.

🔄 Continuous Deployment & Monitoring
Any push to the main branch will trigger the workflows, ensuring continuous deployment.  You can monitor the deployment progress in the "Actions" tab of your GitHub repository.

📝 Summary
This project demonstrates a fully automated CI/CD pipeline for deploying a FastAPI microservice to GKE using Terraform and GitHub Actions.  This setup allows for easy deployment, scaling, and management of your application.


Key changes and explanations:

* **Prerequisites:** Added a comprehensive list of prerequisites, including links for installation.
* **Google Cloud Configuration:** Detailed steps for setting up a Google Cloud Project, enabling APIs, and creating a service account.  Emphasized the importance of securing the service account key.
* **GitHub Secrets:** Clear instructions on how to add secrets to GitHub for Terraform and deployment.  Explained what each secret is for.
* **Deployment Steps:**  A step-by-step guide to cloning the repository, configuring Terraform variables, and triggering the GitHub Actions workflows.
* **Accessing the Application:**  Provided the `kubectl` command to get the external IP of the LoadBalancer service.
* **Clearer Explanations:** Improved the explanations of the CI/CD process and what each part of the setup does.
* **Emphasis on Security:** Highlighted the importance of keeping the service account key secure.
