locals {
  gitops_dir   = var.gitops_dir != "" ? var.gitops_dir : "${path.cwd}/gitops"
  chart_dir    = "${local.gitops_dir}/cloud-operator"
}

resource "null_resource" "setup-gitops" {
  provisioner "local-exec" {
    command = "mkdir -p ${local.chart_dir}"
  }
}

resource "null_resource" "build_subscription" {
  depends_on = [null_resource.setup-gitops]

  provisioner "local-exec" {
    command = "${path.module}/scripts/build-subscription.sh ${var.cluster_type} ${var.operator_namespace} ${var.olm_namespace} ${var.app_namespace}"

    environment = {
      OUTPUT_DIR = local.chart_dir
    }
  }
}

resource "null_resource" "deploy_cloud_operator" {
  count = var.mode != "setup" ? 1 : 0
  depends_on = [null_resource.build_subscription]

  triggers = {
    KUBECONFIG = var.cluster_config_file
    CHART_DIR  = local.chart_dir
  }

  provisioner "local-exec" {
    command = "kubectl apply -f ${self.triggers.CHART_DIR}"

    environment = {
      KUBECONFIG = self.triggers.KUBECONFIG
    }
  }

  provisioner "local-exec" {
    when = destroy

    command = "kubectl delete -f ${self.triggers.CHART_DIR}"

    environment = {
      KUBECONFIG = self.triggers.KUBECONFIG
    }
  }
}
