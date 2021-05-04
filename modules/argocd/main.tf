resource "kubernetes_namespace" "argocd" {
  metadata {
    name = "argocd"
  }
}

resource "kubernetes_secret" "argocd_github_token" {
  metadata {
    name      = "repository"
    namespace = kubernetes_namespace.argocd.metadata[0].name
  }
  data = {
    username = var.argocd_github_username
    password = var.argocd_github_token
  }
}

resource "helm_release" "argocd" {
  name          = "argocd"
  repository    = "https://argoproj.github.io/argo-helm"
  chart         = "argo-cd"
  version       = var.argocd_version
  namespace     = kubernetes_namespace.argocd.metadata[0].name
  recreate_pods = true

  values = [templatefile("${path.module}/templates/argocd.yml", {
    url          = var.argocd_url
    issuer       = var.argocd_auth0_issuer
    clientId     = var.argocd_auth0_clientId
    clientSecret = var.argocd_auth0_clientSecret
    scopeKey     = var.argocd_auth0_scopeKey
    repositories = var.argocd_repositories
    repoSecret   = kubernetes_secret.argocd_github_token.metadata[0].name
  })]
}



