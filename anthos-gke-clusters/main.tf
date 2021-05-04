provider "google" {
    project = var.project_id
}

provider "google-beta" {
    project = var.project_id
}

# data "google_client_config" "default" {}

module "project" {
    source                        = "terraform-google-modules/project-factory/google"
    name                          = var.project_id
    billing_account               = var.billing_account
    org_id                        = var.org_id
    folder_id                     = var.folder_id
    random_project_id             = false

    activate_apis           = [
        "compute.googleapis.com",
        "container.googleapis.com",
        "cloudbilling.googleapis.com",
        "gkehub.googleapis.com",
        "anthos.googleapis.com",
        "multiclusterservicediscovery.googleapis.com",
        "multiclusteringress.googleapis.com",
        "gkeconnect.googleapis.com",
        "trafficdirector.googleapis.com",
        "cloudresourcemanager.googleapis.com"
    ]
}

resource "google_compute_network" "network" {
    name                    = var.network_name
    auto_create_subnetworks = false
    
    depends_on = [
        module.project,
    ]
}

resource "google_compute_firewall" "fw-allow-health-check" {
    name          = "fw-allow-health-check"
    network       = google_compute_network.network.self_link

    allow {
        protocol    = "tcp"
    }

    source_ranges = ["130.211.0.0/22","35.191.0.0/16"]
}

resource "google_compute_subnetwork" "first_subnet" {
    name          = var.first_subnet_name
    ip_cidr_range = "172.16.0.0/16"
    region        = var.first_region
    network       = google_compute_network.network.self_link
    private_ip_google_access   = true
    secondary_ip_range {
        range_name    = "${var.first_subnet_name}-pods"
        ip_cidr_range = "10.1.16.0/20"
    }
    secondary_ip_range {
        range_name    = "${var.first_subnet_name}-services"
        ip_cidr_range = "10.1.32.0/20"
    }
}

resource "google_compute_subnetwork" "second_subnet" {
    name          = var.second_subnet_name
    ip_cidr_range = "172.17.0.0/16"
    region        = var.second_region
    network       = google_compute_network.network.self_link
    private_ip_google_access   = true
    secondary_ip_range {
        range_name    = "${var.second_subnet_name}-pods"
        ip_cidr_range = "10.1.48.0/20"
    }
    secondary_ip_range {
        range_name    = "${var.second_subnet_name}-services"
        ip_cidr_range = "10.1.64.0/20"
    }
}

module "gke1" {
    source                  = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
    project_id              = module.project.project_id
    name                    = "${var.cluster_name_prefix}-cluster1"
    regional                = false
    region                  = var.first_region
    zones                   = [var.first_zone]
    network                 = google_compute_network.network.name
    subnetwork              = google_compute_subnetwork.first_subnet.name
    ip_range_pods           = google_compute_subnetwork.first_subnet.secondary_ip_range[0].range_name
    ip_range_services       = google_compute_subnetwork.first_subnet.secondary_ip_range[1].range_name
    create_service_account  = true
    enable_private_endpoint = false
    enable_private_nodes    = true
    master_ipv4_cidr_block  = "172.18.0.0/28"

    depends_on = [
        module.project,
    ]
}

module "gke2" {
    source                  = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
    project_id              = module.project.project_id
    name                    = "${var.cluster_name_prefix}-cluster2"
    regional                = false
    region                  = var.second_region
    zones                   = [var.second_zone]
    network                 = google_compute_network.network.name
    subnetwork              = google_compute_subnetwork.second_subnet.name
    ip_range_pods           = google_compute_subnetwork.second_subnet.secondary_ip_range[0].range_name
    ip_range_services       = google_compute_subnetwork.second_subnet.secondary_ip_range[1].range_name
    create_service_account  = true
    enable_private_endpoint = false
    enable_private_nodes    = true
    master_ipv4_cidr_block  = "172.18.0.16/28"

    depends_on = [
        module.project,
    ]
}

module "hub1" {
  source           = "terraform-google-modules/kubernetes-engine/google//modules/hub"

  project_id       = module.project.project_id
  cluster_name     = module.gke1.name
  location         = module.gke1.location
  cluster_endpoint = module.gke1.endpoint
  gke_hub_membership_name = var.config_cluster_membership_name
  gke_hub_sa_name  = "first-cluster-sa"
}

module "hub2" {
  source           = "terraform-google-modules/kubernetes-engine/google//modules/hub"

  project_id       = module.project.project_id
  cluster_name     = module.gke2.name
  location         = module.gke2.location
  cluster_endpoint = module.gke2.endpoint
  gke_hub_membership_name = "second"
  gke_hub_sa_name  = "second-cluster-sa"
}
