module "config" {
  source     = "../modules/config"
  config_env = local.env
}

locals {
  config = module.config.data
  kubernetes_config_path = var.KUBERNETES_CONFIG_PATH
}

module "setup_cluster" {
  source                    = "../modules/setup_cluster"
  setup_cluster_config_path = local.kubernetes_config_path
  helm_operator_version     = local.config.helm_operator_version
  fluxcd_version            = local.config.fluxcd_version
}

module "traefik" {
  source                      = "../modules/traefik"
  traefik_cluster_config_path = local.kubernetes_config_path
  traefik_version             = local.config.traefik_version
}

module "argocd" {
  source                      = "../modules/argocd"
  argocd_cluster_config_path = local.kubernetes_config_path
  argocd_version             = local.config.argocd_version
}
