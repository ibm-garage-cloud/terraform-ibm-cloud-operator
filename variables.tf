variable "cluster_config_file" {
  type        = string
  description = "Cluster config file for Kubernetes cluster."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group"
}

variable "region" {
  type        = string
  description = "The name of the region"
}

variable "ibmcloud_api_key" {
  type        = string
  description = "The apikey with access to the IBM Cloud"
}

variable "cluster_type" {
  type        = string
  description = "The type of cluster (openshift or kubernetes)"
}

variable "olm_namespace" {
  type        = string
  description = "Namespace where olm is installed"
}

variable "operator_namespace" {
  type        = string
  description = "Namespace where operators will be installed"
}

variable "app_namespace" {
  type        = string
  description = "Namespace where operators will be installed"
}

variable "name" {
  type        = string
  description = "The name for the instance"
  default     = "cloud-operator"
}

variable "gitops_dir" {
  type        = string
  description = "Directory where the gitops repo content should be written"
  default     = ""
}

variable "mode" {
  type        = string
  description = "The mode of operation for the module (setup)"
  default     = ""
}
