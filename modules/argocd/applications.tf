resource "kubectl_manifest" "argocd_application_workflows" {
  depends_on       = [helm_release.argocd]
  ignore_fields    = ["metadata", "status"]
  sensitive_fields = []
  yaml_body        = file("${path.module}/templates/argocd-application-workflows.yml")
}

resource "kubectl_manifest" "argocd_application_events" {
  depends_on       = [helm_release.argocd]
  ignore_fields    = ["metadata", "status"]
  sensitive_fields = []
  yaml_body        = file("${path.module}/templates/argocd-application-slack-events.yml")
}
