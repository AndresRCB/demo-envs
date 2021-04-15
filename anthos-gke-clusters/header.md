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