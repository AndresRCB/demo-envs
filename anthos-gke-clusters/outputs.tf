output "enable_mcs_command" {
  value       = "gcloud alpha container hub multi-cluster-services enable --project=${var.project_id}"
  description = "Enable Multi-cluster Services in project"
}

output "allow_mcs_command" {
  value       = "gcloud projects add-iam-policy-binding ${var.project_id} --member \"serviceAccount:${var.project_id}.svc.id.goog[gke-mcs/gke-mcs-importer]\" --role \"roles/compute.networkViewer\""
  description = "Allow Multi-cluster Services in project"
}

output "enable_mci_command" {
  value       = "gcloud alpha container hub ingress enable --config-membership=projects/${var.project_id}/locations/global/memberships/${var.config_cluster_membership_name} --project=${var.project_id}"
  description = "Enable Multi-cluster Ingress and set cluster1 as config cluster"
}

output "cluster1_credentials_command" {
  value       = "gcloud container clusters get-credentials ${module.gke1.name} --project=${var.project_id} --zone=${var.first_zone}"
  description = "Command to get cluster1 credentials for kubectl"
}

output "cluster2_credentials_command" {
  value       = "gcloud container clusters get-credentials ${module.gke2.name} --project=${var.project_id} --zone=${var.second_zone}"
  description = "Command to get cluster2 credentials for kubectl"
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

output "cluster1_region" {
    value = var.first_region
    description = "GCP region with cluster1"
}

output "cluster2_region" {
    value = var.second_region
    description = "GCP region with cluster2"
}

output "network_name" {
    value = var.network_name
    description = "Name of the network that will be created for the demo"
}

output "first_subnet_name" {
    value = var.first_subnet_name
    description = "Name of the subnet that will be created for cluster1"
}

output "second_subnet_name" {
    value = var.second_subnet_name
    description = "Name of the subnet that will be created for cluster2"
}

output "cluster1_name" {
    value = module.gke1.name
    description = "Anthos GKE cluster1 name"
}

output "cluster2_name" {
    value = module.gke2.name
    description = "Anthos GKE cluster2 name"
}

output "cluster1_node_cidr_range" {
    value = google_compute_subnetwork.first_subnet.ip_cidr_range
    description = "Node CIDR range for demo cluster1"
}

output "cluster1_pod_cidr_range" {
    value = google_compute_subnetwork.first_subnet.secondary_ip_range[0].ip_cidr_range
    description = "Pod CIDR range in demo cluster1"
}

output "cluster1_service_cidr_range" {
    value = google_compute_subnetwork.first_subnet.secondary_ip_range[1].ip_cidr_range
    description = "Service CIDR range in demo cluster1"
}

output "cluster2_node_cidr_range" {
    value = google_compute_subnetwork.second_subnet.ip_cidr_range
    description = "Node CIDR range for demo cluster2"
}

output "cluster2_pod_cidr_range" {
    value = google_compute_subnetwork.second_subnet.secondary_ip_range[0].ip_cidr_range
    description = "Pod CIDR range in demo cluster2"
}

output "cluster2_service_cidr_range" {
    value = google_compute_subnetwork.second_subnet.secondary_ip_range[1].ip_cidr_range
    description = "Service CIDR range in demo cluster2"
}