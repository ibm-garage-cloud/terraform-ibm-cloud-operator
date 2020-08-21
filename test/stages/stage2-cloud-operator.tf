module "dev_cloud-operator" {
  source = "./module"

  resource_group_name = var.resource_group_name
  resource_location   = var.region
  cluster_config_file = module.dev_cluster.config_file_path
  ibmcloud_api_key    = var.ibmcloud_api_key
}
