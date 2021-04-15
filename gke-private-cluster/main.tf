provider "google" {
    project = var.project_id
    region  = var.region
    zone = var.zone
}

provider "google-beta" {
    project = var.project_id
    region  = var.region
    zone = var.zone
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
        "cloudbilling.googleapis.com"
    ]
}

resource "google_compute_network" "network" {
    name                    = var.network_name
    auto_create_subnetworks = false
    
    depends_on = [
        module.project,
    ]
}

resource "google_compute_subnetwork" "subnetwork" {
    name          = var.subnet_name
    ip_cidr_range = "172.16.0.0/16"
    region        = var.region
    network       = google_compute_network.network.self_link
    private_ip_google_access   = true
    secondary_ip_range {
        range_name    = "${var.subnet_name}-pods"
        ip_cidr_range = "10.1.16.0/20"
    }
    secondary_ip_range {
        range_name    = "${var.subnet_name}-services"
        ip_cidr_range = "10.1.32.0/20"
    }
}

resource "google_compute_subnetwork" "proxy_only_subnet" {
    provider = google-beta

    name          = "proxy-only-subnet"
    ip_cidr_range = "10.129.0.0/23"
    region        = var.region
    purpose       = "INTERNAL_HTTPS_LOAD_BALANCER"
    role          = "ACTIVE"
    network       = google_compute_network.network.self_link
}

resource "google_compute_firewall" "fw-allow-proxies" {
    name          = "fw-allow-proxies"
    network       = google_compute_network.network.self_link

    allow {
        protocol    = "tcp"
        ports       = ["80", "8080", "443", "8443"]
    }

    source_ranges = [
        google_compute_subnetwork.proxy_only_subnet.ip_cidr_range,
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

resource "google_compute_firewall" "fw-allow-ssh" {
    name          = "fw-allow-ssh"
    network       = google_compute_network.network.self_link

    allow {
        protocol    = "tcp"
        ports       = ["22"]
    }

    target_tags = ["allow-ssh"]
}

resource "google_compute_instance" "vm_instance" {
    name         = "vm-instance"
    machine_type = "e2-medium"
    allow_stopping_for_update = true

    tags = ["allow-ssh"]

    boot_disk {
        initialize_params {
            image = "debian-cloud/debian-10"
            size  = 200
            type = "pd-ssd"
        }
    }

    network_interface {
        subnetwork = google_compute_subnetwork.subnetwork.self_link
        access_config {}
    }
}

module "gke" {
    source                  = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
    project_id              = module.project.project_id
    name                    = "cluster-${var.cluster_name_suffix}"
    regional                = false
    region                  = var.region
    zones                   = [var.zone]
    network                 = google_compute_network.network.name
    subnetwork              = google_compute_subnetwork.subnetwork.name
    ip_range_pods           = google_compute_subnetwork.subnetwork.secondary_ip_range[0].range_name
    ip_range_services       = google_compute_subnetwork.subnetwork.secondary_ip_range[1].range_name
    create_service_account  = true
    enable_private_endpoint = false
    enable_private_nodes    = true
    master_ipv4_cidr_block  = "172.17.0.0/28"

    depends_on = [
        module.project,
    ]
}