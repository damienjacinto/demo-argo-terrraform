provider "kubernetes" {
  config_path = var.argocd_cluster_config_path
}

provider "helm" {
  kubernetes {
    config_path = var.argocd_cluster_config_path
  }
}
