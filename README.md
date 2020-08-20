# IBM Cloud Operator terraform module

This terraform module installs the IBM Cloud operator into a cluster.

## Software dependencies

The module depends on the following software components:

### Command-line tools

- terraform - v12
- kubectl

### Terraform providers

None

## Module dependencies

This module makes use of the output from other modules:

- Cluster - github.com/ibm-garage-cloud/terraform-ibm-container-platform.git

## Example usage

```hcl-terraform
module "dev_cloud_operator" {
  source = "github.com/ibm-garage-cloud/terraform-ibm-cloud-operator?ref=v1.0.0"

  resource_group_name = var.resource_group_name
  resource_location   = var.region
  cluster_config_file = module.dev_cluster.config_file_path
  ibmcloud_api_key    = module.dev_cluster.ibmcloud_api_key
}
```
