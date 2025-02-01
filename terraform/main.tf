provider "google" {
  credentials = file(var.credentials_file_path)  # GCP credentials file
  project     = var.project_id
  region      = var.region
}

# Create a GCS bucket to store Terraform state
resource "google_storage_bucket" "terraform_state" {
  name     = "webservice-terraform-state-bucket"
  location = "us-central1"
  uniform_bucket_level_access = true

  versioning {
    enabled = true
  }
}

# VPC Creation
resource "google_compute_network" "vpc" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
}

# Public Subnet 1
resource "google_compute_subnetwork" "public_1" {
  name          = "public-subnet-1"
  network       = google_compute_network.vpc.name
  region        = var.region
  ip_cidr_range = var.subnet_cidr_public_1
}

# Public Subnet 2
resource "google_compute_subnetwork" "public_2" {
  name          = "public-subnet-2"
  network       = google_compute_network.vpc.name
  region        = var.region
  ip_cidr_range = var.subnet_cidr_public_2
}

# Private Subnet 1
resource "google_compute_subnetwork" "private_1" {
  name          = "private-subnet-1"
  network       = google_compute_network.vpc.name
  region        = var.region
  ip_cidr_range = var.subnet_cidr_private_1
  private_ip_google_access = true
}

# Private Subnet 2
resource "google_compute_subnetwork" "private_2" {
  name          = "private-subnet-2"
  network       = google_compute_network.vpc.name
  region        = var.region
  ip_cidr_range = var.subnet_cidr_private_2
  private_ip_google_access = true
}

#nat
resource "google_compute_router" "nat_router" {
  name    = "nat-router"
  network = google_compute_network.vpc.name
  region  = var.region
}

resource "google_compute_router_nat" "nat" {
  name                               = "nat-gateway"
  router                             = google_compute_router.nat_router.name
  region                             = var.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}


# Firewall Rule to Allow Access to GKE Nodes
resource "google_compute_firewall" "allow_gke_access" {
  name    = var.firewall_name
  network = google_compute_network.custom_vpc.name

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]  # Allow access from anywhere (can be restricted as needed)
}

# Create GKE Cluster
resource "google_container_cluster" "gke" {
  name     = var.gke_cluster_name
  location = var.region

  remove_default_node_pool = true
  initial_node_count       = 1

  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.private_1.name
}
# Create node pool for gke cluster
resource "google_container_node_pool" "node_pool" {
  cluster   = google_container_cluster.gke.name
  location  = var.region

  node_config {
    machine_type = var.node_machine_type
    oauth_scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  initial_node_count = var.initial_node_count
}
