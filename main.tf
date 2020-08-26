locals {
  module_path = substr(path.module, 0, 1) == "/" ? path.module : "./${path.module}"
}

resource "null_resource" "test" {
  provisioner "local-exec" {
    command = "echo ${path.module} && echo ${local.module_path} && ls -lA ${path.module} && ls -lA ${path.module}/scripts"

    environment={
      KUBECONFIG = var.cluster_config_file
      APIKEY     = var.ibmcloud_api_key
    }
  }
}

resource "null_resource" "deploy_cloud_operator" {
  depends_on = [null_resource.test]

  provisioner "local-exec" {
    command = "${local.module_path}/scripts/deploy-cloud-operator.sh ${var.resource_group_name} ${var.resource_location}"

    environment={
      KUBECONFIG = var.cluster_config_file
      APIKEY     = var.ibmcloud_api_key
    }
  }
}
