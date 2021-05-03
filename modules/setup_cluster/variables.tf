variable "setup_cluster_config_path" {
  type        = string
  description = "kubernetes config path"
  sensitive   = true
}

variable "helm_operator_version" {
  type       = string
  description = "Helm operator chart version"
}

variable "fluxcd_version" {
  type       = string
  description = "Fluxcd chart version"
}
