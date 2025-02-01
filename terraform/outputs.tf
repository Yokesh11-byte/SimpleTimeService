output "gke_cluster_name" {
  value = google_container_cluster.gke.name
}

output "vpc_name" {
  value = google_compute_network.vpc.name
}

output "nat_gateway_name" {
  value = google_compute_router_nat.nat.name
}
