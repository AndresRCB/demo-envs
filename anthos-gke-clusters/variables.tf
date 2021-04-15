variable "org_id" {
    type = string
    description = "An existing organization ID for the demo project"
}

variable "project_id" {
    type = string
    description = "a New and unique project ID for the demo project to be created"
}

variable "billing_account" {
    type = string
    description = "An existing billing account to be charged for this demo"
}

variable "folder_id" {
    type = string
    description = "An existing folder ID for the demo project to be created into"
    default = ""
}

variable "first_region" {
    type = string
    default = "us-east1"
    description = "GCP region to create resources for the first cluster"
}

variable "first_zone" {
    type = string
    default = "us-east1-c"
    description = "GCP zone to create resources for the first cluster"
}

variable "second_region" {
    type = string
    default = "us-west1"
    description = "GCP region to create resources for the second cluster"
}

variable "second_zone" {
    type = string
    default = "us-west1-a"
    description = "GCP zone to create resources for the second cluster"
}

variable "network_name" {
    type = string
    default = "anthos-gke-network"
    description = "Name of the network that will be created for the demo"
}

variable "first_subnet_name" {
    type = string
    default = "first-cluster-subnet"
    description = "Name of the subnet that will be created for the first demo cluster"
}

variable "second_subnet_name" {
    type = string
    default = "second-cluster-subnet"
    description = "Name of the subnet that will be created for the second demo cluster"
}

variable "cluster_name_prefix" {
    type = string
    default = "anthos-gke"
    description = "Cluster prefix for this demo"
}

variable "config_cluster_membership_name" {
    type = string
    default = "first"
    description = "Config cluster membership name in GKE hub"
}