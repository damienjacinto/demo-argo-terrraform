variable "argocd_cluster_config_path" {
  type        = string
  description = "kubernetes config path"
  sensitive   = true
}

variable "argocd_version" {
  type        = string
  description = "Argocd chart version"
}

