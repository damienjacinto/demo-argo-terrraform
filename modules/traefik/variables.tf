variable "traefik_cluster_config_path" {
  type        = string
  description = "kubernetes config path"
  sensitive   = true
}

variable "traefik_version" {
  type       = string
  description = "Traefik chart version"
}

