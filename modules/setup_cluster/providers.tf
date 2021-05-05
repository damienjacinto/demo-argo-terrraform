provider "kubernetes" {
  config_path = var.setup_cluster_config_path
}

provider "helm" {
  kubernetes {
    config_path = var.setup_cluster_config_path
  }
}
