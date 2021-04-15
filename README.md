# Demo Environments for the Cloud

This repo contains Terraform modules that create disposable Cloud environments for scratch that can be used for interesting demos. For instance, Multi-Cluster Ingress (MCI) across regions on Google Cloud.

## Usage
Simply create use the terraform module with at least the required arguments (packages have more options but are opinionated for ease of use):
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

## Cleaning up
Most (if not all) demo environments will create a new account/project so that you can easily destroy them after use. That said, you can use the `terraform destroy` command as well, but it would take longer and might fail if you modified some resources during the demo.