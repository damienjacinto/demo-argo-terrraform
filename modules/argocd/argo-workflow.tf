resource "kubernetes_namespace" "argo" {
  metadata {
    name = "argo"
  }
}

resource "kubernetes_secret" "argoworflow_auth0" {
  metadata {
    name      = "argoworflow-auth0"
    namespace = kubernetes_namespace.argo.metadata[0].name
  }
  data = {
    clientid-key = var.argocd_auth0_clientId
    secret-key   = var.argocd_auth0_clientSecret
  }
}

resource "helm_release" "argo" {
  name          = "argo"
  repository    = "https://argoproj.github.io/argo-helm"
  chart         = "argo"
  version       = var.argoworkflow_version
  namespace     = kubernetes_namespace.argo.metadata[0].name
  recreate_pods = true

  values = [templatefile("${path.module}/templates/argoworkflow.yml", {
    url          = var.argoworkflow_url
    issuer       = var.argocd_auth0_issuer
    auth0Secret  = kubernetes_secret.argoworflow_auth0.metadata[0].name
    imageVersion = var.argoworkflow_image_version
  })]
}
