module "config" {
  source     = "../modules/config"
  config_env = local.env
}

locals {
  config                 = module.config.data
  kubernetes_config_path = var.KUBERNETES_CONFIG_PATH
  auth0_issuer           = var.AUTH_ISSUER
  auth0_clientId         = var.AUTH_CLIENTID
  auth0_clientSecret     = var.AUTH_CLIENTSECRET
  slack_token            = var.SLACK_TOKEN
  github_secret          = var.GITHUB_SECRET
  github_token           = var.GITHUB_TOKEN
  github_username        = var.GITHUB_USERNAME
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
  source                        = "../modules/argocd"
  argocd_version                = local.config.argocd_version
  argocd_cluster_config_path    = local.kubernetes_config_path
  argocd_url                    = local.config.argocd_url
  argocd_auth0_issuer           = local.auth0_issuer
  argocd_auth0_clientId         = local.auth0_clientId
  argocd_auth0_clientSecret     = local.auth0_clientSecret
  argocd_auth0_scopeKey         = local.config.argocd_auth0_scopeKey
  argo_notification_slack_token = local.slack_token
  argo_notification_version     = local.config.argo_notification_version
  argo_notification_icon        = local.config.argo_notification_icon
  argocd_webhook_github_secret  = local.github_secret
  argocd_github_token           = local.github_token
  argocd_github_username        = local.github_username
  argocd_projects               = local.config.argocd_projects
  argo_events_version           = local.config.argo_events_version
  argoworkflow_url              = local.config.argoworkflow_url
  argoworkflow_version          = local.config.argoworkflow_version
  argoworkflow_image_version    = local.config.argoworkflow_image_version
  argoworkflow_admin_rule       = local.config.argoworkflow_admin_rule
  argocd_repositories           = local.config.argocd_repositories
}
