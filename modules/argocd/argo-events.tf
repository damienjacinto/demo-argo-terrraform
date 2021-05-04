resource "kubernetes_namespace" "argo_events" {
  metadata {
    name = "argo-events"
  }
}

resource "helm_release" "argo-events" {
  name       = "argo-events"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-events"
  version    = var.argo_events_version
  namespace  = kubernetes_namespace.argo_events.metadata[0].name
}
