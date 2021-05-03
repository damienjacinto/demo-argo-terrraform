output "data" {
  value = {
    env                   = "local"
    helm_operator_version = "1.2.0"
    fluxcd_version        = "1.9.0"
    traefik_version       = "9.19.0"
    argocd_version        = "3.2.2"
  }
}
