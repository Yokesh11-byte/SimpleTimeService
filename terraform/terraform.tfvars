project_id = "your-gcp-project-id"
region     = "us-central1"

vpc_name = "devops-vpc"

gke_cluster_name  = "devops-gke-cluster"
node_machine_type = "e2-medium"
initial_node_count = 2

subnet_cidr_private_1 = "10.0.1.0/24"
subnet_cidr_private_2 = "10.0.2.0/24"
subnet_cidr_public_1  = "10.0.3.0/24"
subnet_cidr_public_2  = "10.0.4.0/24"


firewall_name      = "allow-gke-access"

