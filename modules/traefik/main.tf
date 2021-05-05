resource "kubernetes_namespace" "traefik" {
  metadata {
    name = "traefik"
  }
}

resource "helm_release" "traefik" {
  name       = "traefik"
  repository = "https://helm.traefik.io/traefik"
  chart      = "traefik"
  version    = var.traefik_version
  namespace  = kubernetes_namespace.traefik.metadata[0].name
}

resource "kubectl_manifest" "ingressroute-dashboard" {
  yaml_body = templatefile("${path.module}/templates/ingressroute-dashboard.yml", {
    namespace = kubernetes_namespace.traefik.metadata[0].name
  })
}
