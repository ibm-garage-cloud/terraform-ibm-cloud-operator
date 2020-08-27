module "dev_cloud-operator" {
  source = "./module"

  cluster_config_file = module.dev_cluster.config_file_path
  resource_group_name = var.resource_group_name
  region              = var.region
  ibmcloud_api_key    = var.ibmcloud_api_key
  cluster_type        = module.dev_cluster.type_code
  olm_namespace       = module.dev_capture_olm_state.namespace
  operator_namespace  = module.dev_capture_operator_state.namespace
  app_namespace       = module.dev_capture_tools_state.namespace
}
