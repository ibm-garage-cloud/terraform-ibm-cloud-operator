resource "null_resource" "test" {
  provisioner "local-exec" {
    command = "echo ${path.module} && ls -lA ${path.module} && ls -lA ${path.module}/scripts"

    environment={
      KUBECONFIG = var.cluster_config_file
      APIKEY     = var.ibmcloud_api_key
    }
  }
}

resource "null_resource" "deploy_cloud_operator" {
  depends_on = [null_resource.test]

  provisioner "local-exec" {
    command = "${path.module}/scripts/deploy-cloud-operator.sh ${var.resource_group_name} ${var.resource_location}"

    environment={
      KUBECONFIG = var.cluster_config_file
      APIKEY     = var.ibmcloud_api_key
    }
  }
}
