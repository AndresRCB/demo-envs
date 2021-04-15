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