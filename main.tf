provider "ibm" {
  version = ">= 1.9.0"
  region  = var.region
}

provider "helm" {
  version = ">= 1.1.1"

  kubernetes {
    config_path = var.cluster_config_file
  }
}

locals {
  gitops_dir   = var.gitops_dir != "" ? var.gitops_dir : "${path.cwd}/gitops"
  chart_dir    = "${local.gitops_dir}/cloud-operator"
  global_config    = {
    clusterType = var.cluster_type
  }
  cloud_operator_config = {
    apiKey = var.ibmcloud_api_key
    resourceGroup = var.resource_group_name
    resourceGroupId = data.ibm_resource_group.resource_group.id
    region = var.region
    user = ""
  }
}

data "ibm_resource_group" "resource_group" {
  name = var.resource_group_name
}

resource "null_resource" "setup-chart" {
  provisioner "local-exec" {
    command = "mkdir -p ${local.chart_dir} && cp -R ${path.module}/chart/ibmcloud-operator/* ${local.chart_dir}"
  }
}

resource "local_file" "ibmcloud-operator-values" {
  depends_on = [null_resource.setup-chart]

  content  = yamlencode({
    global = local.global_config
    ibmcloud-operator = local.cloud_operator_config
  })
  filename = "${local.chart_dir}/values.yaml"
}

resource "null_resource" "print-values" {
  provisioner "local-exec" {
    command = "cat ${local_file.ibmcloud-operator-values.filename}"
  }
}

resource "helm_release" "ibmcloud-operator" {
  depends_on = [local_file.ibmcloud-operator-values]
  count = var.mode != "setup" ? 1 : 0

  name              = "ibmcloud-operator"
  chart             = local.chart_dir
  namespace         = var.app_namespace
  timeout           = 1200
  dependency_update = true
  force_update      = true
  replace           = true

  disable_openapi_validation = true

  values = [local_file.ibmcloud-operator-values.content]
}
