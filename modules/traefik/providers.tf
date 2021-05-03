provider "kubernetes" {
  config_path = var.traefik_cluster_config_path
}

provider "helm" {
  kubernetes {
    config_path = var.traefik_cluster_config_path
  }
}
