resource "kubectl_manifest" "argocd_project" {
  for_each         = { for project in var.argocd_projects : project.name => project }
  depends_on       = [helm_release.argocd]
  ignore_fields    = ["metadata"]
  sensitive_fields = []
  yaml_body = templatefile("${path.module}/templates/argocd-projects.yml", {
    namespace            = kubernetes_namespace.argocd.metadata[0].name
    name                 = each.value.name
    description          = each.value.description
    destinationNamespace = each.value.namespace
    server               = each.value.server
    sourceRepos          = each.value.sourceRepos
    serverChannel        = each.value.serverChannel
  })
}
