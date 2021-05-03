resource "kubernetes_namespace" "fluxcd" {
  metadata {
    name = "fluxcd"
  }
}

resource "helm_release" "helm_operator" {
  name       = "helm-operator"
  repository = "https://charts.fluxcd.io"
  chart      = "helm-operator"
  version    = var.helm_operator_version
  namespace  = kubernetes_namespace.fluxcd.metadata[0].name

  set {
    name  = "helm.versions"
    value = "v3"
  }
}

resource "helm_release" "fluxcd" {
  depends_on = [helm_release.helm_operator]
  name       = "flux"
  repository = "https://charts.fluxcd.io"
  chart      = "flux"
  version    = var.fluxcd_version
  namespace  = kubernetes_namespace.fluxcd.metadata[0].name
}
