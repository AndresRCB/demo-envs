output "instance_connect_command" {
  value       = "gcloud compute ssh --project=${var.project_id} --zone=${google_compute_instance.vm_instance.zone} ${google_compute_instance.vm_instance.name}"
  description = "Command to connect to instance via SSH"
}

output "get_cluster_credentials_command" {
  value       = "gcloud container clusters get-credentials ${module.gke.name} --project=${var.project_id} --zone=${var.zone}"
  description = "Command to get cluster credentials for kubectl"
}

output "org_id" {
    value = var.org_id
    description = "Organization ID for the demo project"
}

output "project_id" {
    value = var.project_id
    description = "Unique project ID for the demo project"
}

output "folder_id" {
    value = var.folder_id
    description = "Folder ID for the demo project"
}

output "region" {
    value = var.region
    description = "GCP region with demo resources"
}

output "network_name" {
    value = var.network_name
    description = "Name of the network that will be created for the demo"
}

output "subnet_name" {
    value = var.subnet_name
    description = "Name of the subnet that will be created for the demo cluster"
}

output "cluster_name" {
    value = module.gke.name
    description = "GKE cluster name"
}

output "cluster_node_cidr_range" {
    value = google_compute_subnetwork.subnetwork.ip_cidr_range
    description = "Node CIDR range for demo cluster"
}

output "cluster_pod_cidr_range" {
    value = google_compute_subnetwork.subnetwork.secondary_ip_range[0].ip_cidr_range
    description = "Pod CIDR range in demo cluster"
}

output "cluster_service_cidr_range" {
    value = google_compute_subnetwork.subnetwork.secondary_ip_range[1].ip_cidr_range
    description = "Service CIDR range in demo cluster"
}