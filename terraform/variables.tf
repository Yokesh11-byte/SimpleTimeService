variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "credentials_file_path" {
  description = "Path to GCP credentials JSON file"
  type        = string
}

variable "region" {
  description = "GCP Region"
  type        = string
  default     = "us-central1"
}

variable "vpc_name" {
  description = "VPC Name"
  type        = string
  default     = "devops-vpc"
}

variable "gke_cluster_name" {
  description = "GKE Cluster Name"
  type        = string
  default     = "devops-gke-cluster"
}

variable "subnet_cidr_private_1" {
  description = "Private Subnet 1 CIDR"
  type        = string
  default     = "10.0.1.0/24"
}

variable "subnet_cidr_private_2" {
  description = "Private Subnet 2 CIDR"
  type        = string
  default     = "10.0.2.0/24"
}

variable "subnet_cidr_public_1" {
  description = "Public Subnet 1 CIDR"
  type        = string
  default     = "10.0.3.0/24"
}

variable "subnet_cidr_public_2" {
  description = "Public Subnet 2 CIDR"
  type        = string
  default     = "10.0.4.0/24"
}

variable "node_machine_type" {
  description = "Machine Type for GKE Nodes"
  type        = string
  default     = "e2-medium"
}

variable "initial_node_count" {
  description = "Initial Node Count"
  type        = number
  default     = 2
}
