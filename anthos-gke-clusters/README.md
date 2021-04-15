# Anthos GKE Clusters

Two GKE Clusters in a custom network, in different regions, using private nodes and a public endpoint. Both clusters will be registered to the same Anthos GKE Hub to leverage multi-cluster features such as Multi-cluster Ingress (MCI).

## Usage

```hcl
module "anthos_gke_clusters" {
    source              = "github.com/andresrcb/demo-envs/anthos-gke-clusters"
    project_id          = "unique-project-id"
    billing_account     = ""
    org_id              = ""
    # Folder is optional
    # folder_id           = ""
}

output "enable_mci_command" {
  value       = module.anthos_gke_clusters.enable_mci_command
  description = "Enable Multi-cluster Ingress and set cluster1 as config cluster"
}

output "cluster1_credentials_command" {
  value       = module.anthos_gke_clusters.cluster1_credentials_command
  description = "Command to get cluster credentials for kubectl for cluster 1"
}

output "cluster2_credentials_command" {
  value       = module.anthos_gke_clusters.cluster1_credentials_command
  description = "Command to get cluster credentials for kubectl for cluster 2"
}

output "cluster1_region" {
  value       = module.anthos_gke_clusters.cluster1_region
  description = "GCP Region for cluster 1"
}

output "cluster2_region" {
  value       = module.anthos_gke_clusters.cluster2_region
  description = "GCP Region for cluster 2"
}
```
## Development

Modify `header.md` to modify this section of the `README.md` file.

To generate docs, install [terraform-docs](https://github.com/terraform-docs/terraform-docs#installation) and run:
```sh
terraform-docs markdown . --header-from header.md > README.md
```

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_gke1"></a> [gke1](#module\_gke1) | terraform-google-modules/kubernetes-engine/google//modules/private-cluster |  |
| <a name="module_gke2"></a> [gke2](#module\_gke2) | terraform-google-modules/kubernetes-engine/google//modules/private-cluster |  |
| <a name="module_hub1"></a> [hub1](#module\_hub1) | terraform-google-modules/kubernetes-engine/google//modules/hub |  |
| <a name="module_hub2"></a> [hub2](#module\_hub2) | terraform-google-modules/kubernetes-engine/google//modules/hub |  |
| <a name="module_project"></a> [project](#module\_project) | terraform-google-modules/project-factory/google |  |

## Resources

| Name | Type |
|------|------|
| [google_compute_firewall.fw-allow-health-check](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_network.network](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network) | resource |
| [google_compute_subnetwork.first_subnet](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork) | resource |
| [google_compute_subnetwork.second_subnet](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_billing_account"></a> [billing\_account](#input\_billing\_account) | An existing billing account to be charged for this demo | `string` | n/a | yes |
| <a name="input_cluster_name_prefix"></a> [cluster\_name\_prefix](#input\_cluster\_name\_prefix) | Cluster prefix for this demo | `string` | `"anthos-gke"` | no |
| <a name="input_config_cluster_membership_name"></a> [config\_cluster\_membership\_name](#input\_config\_cluster\_membership\_name) | Config cluster membership name in GKE hub | `string` | `"first"` | no |
| <a name="input_first_region"></a> [first\_region](#input\_first\_region) | GCP region to create resources for the first cluster | `string` | `"us-east1"` | no |
| <a name="input_first_subnet_name"></a> [first\_subnet\_name](#input\_first\_subnet\_name) | Name of the subnet that will be created for the first demo cluster | `string` | `"first-cluster-subnet"` | no |
| <a name="input_first_zone"></a> [first\_zone](#input\_first\_zone) | GCP zone to create resources for the first cluster | `string` | `"us-east1-c"` | no |
| <a name="input_folder_id"></a> [folder\_id](#input\_folder\_id) | An existing folder ID for the demo project to be created into | `string` | `""` | no |
| <a name="input_network_name"></a> [network\_name](#input\_network\_name) | Name of the network that will be created for the demo | `string` | `"anthos-gke-network"` | no |
| <a name="input_org_id"></a> [org\_id](#input\_org\_id) | An existing organization ID for the demo project | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | a New and unique project ID for the demo project to be created | `string` | n/a | yes |
| <a name="input_second_region"></a> [second\_region](#input\_second\_region) | GCP region to create resources for the second cluster | `string` | `"us-west1"` | no |
| <a name="input_second_subnet_name"></a> [second\_subnet\_name](#input\_second\_subnet\_name) | Name of the subnet that will be created for the second demo cluster | `string` | `"second-cluster-subnet"` | no |
| <a name="input_second_zone"></a> [second\_zone](#input\_second\_zone) | GCP zone to create resources for the second cluster | `string` | `"us-west1-a"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster1_credentials_command"></a> [cluster1\_credentials\_command](#output\_cluster1\_credentials\_command) | Command to get cluster1 credentials for kubectl |
| <a name="output_cluster1_name"></a> [cluster1\_name](#output\_cluster1\_name) | Anthos GKE cluster1 name |
| <a name="output_cluster1_node_cidr_range"></a> [cluster1\_node\_cidr\_range](#output\_cluster1\_node\_cidr\_range) | Node CIDR range for demo cluster1 |
| <a name="output_cluster1_pod_cidr_range"></a> [cluster1\_pod\_cidr\_range](#output\_cluster1\_pod\_cidr\_range) | Pod CIDR range in demo cluster1 |
| <a name="output_cluster1_region"></a> [cluster1\_region](#output\_cluster1\_region) | GCP region with cluster1 |
| <a name="output_cluster1_service_cidr_range"></a> [cluster1\_service\_cidr\_range](#output\_cluster1\_service\_cidr\_range) | Service CIDR range in demo cluster1 |
| <a name="output_cluster2_credentials_command"></a> [cluster2\_credentials\_command](#output\_cluster2\_credentials\_command) | Command to get cluster2 credentials for kubectl |
| <a name="output_cluster2_name"></a> [cluster2\_name](#output\_cluster2\_name) | Anthos GKE cluster2 name |
| <a name="output_cluster2_node_cidr_range"></a> [cluster2\_node\_cidr\_range](#output\_cluster2\_node\_cidr\_range) | Node CIDR range for demo cluster2 |
| <a name="output_cluster2_pod_cidr_range"></a> [cluster2\_pod\_cidr\_range](#output\_cluster2\_pod\_cidr\_range) | Pod CIDR range in demo cluster2 |
| <a name="output_cluster2_region"></a> [cluster2\_region](#output\_cluster2\_region) | GCP region with cluster2 |
| <a name="output_cluster2_service_cidr_range"></a> [cluster2\_service\_cidr\_range](#output\_cluster2\_service\_cidr\_range) | Service CIDR range in demo cluster2 |
| <a name="output_enable_mci_command"></a> [enable\_mci\_command](#output\_enable\_mci\_command) | Enable Multi-cluster Ingress and set cluster1 as config cluster |
| <a name="output_first_subnet_name"></a> [first\_subnet\_name](#output\_first\_subnet\_name) | Name of the subnet that will be created for cluster1 |
| <a name="output_folder_id"></a> [folder\_id](#output\_folder\_id) | Folder ID for the demo project |
| <a name="output_network_name"></a> [network\_name](#output\_network\_name) | Name of the network that will be created for the demo |
| <a name="output_org_id"></a> [org\_id](#output\_org\_id) | Organization ID for the demo project |
| <a name="output_project_id"></a> [project\_id](#output\_project\_id) | Unique project ID for the demo project |
| <a name="output_second_subnet_name"></a> [second\_subnet\_name](#output\_second\_subnet\_name) | Name of the subnet that will be created for cluster2 |
