module "dev_cloud-operator" {
  source = "./module"

  resource_group_name = module.dev_cluster.resource_group
  resource_location   = module.dev_cluster.region
  cluster_config_file = module.dev_cluster.config_file_path
  ibmcloud_api_key    = var.ibmcloud_api_key
}
