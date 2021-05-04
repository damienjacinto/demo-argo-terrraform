resource "kubernetes_secret" "argo-notification" {
  metadata {
    name      = "argocd-notifications-secret"
    namespace = kubernetes_namespace.argocd.metadata[0].name
  }
  data = {
    slack-token = var.argo_notification_slack_token
  }
}

resource "helm_release" "argo-notification" {
  name          = "argocd-notifications"
  repository    = "https://argoproj.github.io/argo-helm"
  chart         = "argocd-notifications"
  version       = var.argo_notification_version
  namespace     = kubernetes_namespace.argocd.metadata[0].name
  recreate_pods = true

  values = [templatefile("${path.module}/templates/argocd-notifications.yml", {
    url   = var.argocd_url
    icone = var.argo_notification_icon
  })]
}
