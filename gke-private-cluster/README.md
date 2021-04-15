# GKE Private Cluster

A GKE cluster in a custom network with private nodes and a public endpoint for ease of use. This module also creates a VM for administration and testing purposes (e.g. curl internal load balancers).

## Usage

```hcl
module "gke_ingress_demo" {
    source              = "github.com/andresrcb/demo-envs/gke-private-cluster"
    project_id          = "unique-project-id"
    billing_account     = ""
    org_id              = ""
    # Folder is optional
    # folder_id           = ""
}

output "instance_connect_command" {
  value       = module.gke_ingress_demo.instance_connect_command
  description = "Command to connect to instance via SSH"
}

output "get_cluster_credentials_command" {
  value       = module.gke_ingress_demo.get_cluster_credentials_command
  description = "Command to get cluster credentials for kubectl"
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
| <a name="provider_google-beta"></a> [google-beta](#provider\_google-beta) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_gke"></a> [gke](#module\_gke) | terraform-google-modules/kubernetes-engine/google//modules/private-cluster |  |
| <a name="module_project"></a> [project](#module\_project) | terraform-google-modules/project-factory/google |  |

## Resources

| Name | Type |
|------|------|
| [google-beta_google_compute_subnetwork.proxy_only_subnet](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_compute_subnetwork) | resource |
| [google_compute_firewall.fw-allow-health-check](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_firewall.fw-allow-proxies](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_firewall.fw-allow-ssh](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_instance.vm_instance](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance) | resource |
| [google_compute_network.network](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network) | resource |
| [google_compute_subnetwork.subnetwork](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_billing_account"></a> [billing\_account](#input\_billing\_account) | An existing billing account to be charged for this demo | `string` | n/a | yes |
| <a name="input_cluster_name_suffix"></a> [cluster\_name\_suffix](#input\_cluster\_name\_suffix) | cluster suffix for this demo | `string` | `"gke-demo"` | no |
| <a name="input_folder_id"></a> [folder\_id](#input\_folder\_id) | An existing folder ID for the demo project to be created into | `string` | `""` | no |
| <a name="input_network_name"></a> [network\_name](#input\_network\_name) | Name of the network that will be created for the demo | `string` | `"gke-demo-network"` | no |
| <a name="input_org_id"></a> [org\_id](#input\_org\_id) | An existing organization ID for the demo project | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | a New and unique project ID for the demo project to be created | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | GCP region to create resources | `string` | `"us-central1"` | no |
| <a name="input_subnet_name"></a> [subnet\_name](#input\_subnet\_name) | Name of the subnet that will be created for the demo cluster | `string` | `"gke-demo-subnet"` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | GCP zone to create resources | `string` | `"us-central1-a"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | GKE cluster name |
| <a name="output_cluster_node_cidr_range"></a> [cluster\_node\_cidr\_range](#output\_cluster\_node\_cidr\_range) | Node CIDR range for demo cluster |
| <a name="output_cluster_pod_cidr_range"></a> [cluster\_pod\_cidr\_range](#output\_cluster\_pod\_cidr\_range) | Pod CIDR range in demo cluster |
| <a name="output_cluster_service_cidr_range"></a> [cluster\_service\_cidr\_range](#output\_cluster\_service\_cidr\_range) | Service CIDR range in demo cluster |
| <a name="output_folder_id"></a> [folder\_id](#output\_folder\_id) | Folder ID for the demo project |
| <a name="output_get_cluster_credentials_command"></a> [get\_cluster\_credentials\_command](#output\_get\_cluster\_credentials\_command) | Command to get cluster credentials for kubectl |
| <a name="output_instance_connect_command"></a> [instance\_connect\_command](#output\_instance\_connect\_command) | Command to connect to instance via SSH |
| <a name="output_network_name"></a> [network\_name](#output\_network\_name) | Name of the network that will be created for the demo |
| <a name="output_org_id"></a> [org\_id](#output\_org\_id) | Organization ID for the demo project |
| <a name="output_project_id"></a> [project\_id](#output\_project\_id) | Unique project ID for the demo project |
| <a name="output_region"></a> [region](#output\_region) | GCP region with demo resources |
| <a name="output_subnet_name"></a> [subnet\_name](#output\_subnet\_name) | Name of the subnet that will be created for the demo cluster |
