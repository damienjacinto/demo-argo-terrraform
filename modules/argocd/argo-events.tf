resource "kubernetes_namespace" "argo_events" {
  metadata {
    name = "argo-events"
  }
}

resource "kubernetes_secret" "argo_events" {
  metadata {
    name      = "slack-secret"
    namespace = kubernetes_namespace.argo_events.metadata[0].name
  }
  data = {
    tokenkey      = var.argoevent_slack_deploy_secret
    signingSecret = var.argoevent_slack_signin_secret
  }
}

resource "kubernetes_service_account" "operate_workflow" {
  metadata {
    name      = "operate-workflow"
    namespace = kubernetes_namespace.argo_events.metadata[0].name
  }
}

resource "kubernetes_cluster_role" "operate_workflow" {
  metadata {
    name      = "operate-workflow"
  }
  rule {
    api_groups = ["argoproj.io"]
    resources  = ["workflows","workflowtemplates","cronworkflows","clusterworkflowtemplates","apiGroups"]
    verbs      = ["*"]
  }

  rule {
    api_groups = [""]
    resources  = ["pods"]
    verbs      = ["get","watch","patch"]
  }

  rule {
    api_groups = [""]
    resources  = ["pods/log"]
    verbs      = ["get","watch"]
  }
}

resource "kubernetes_cluster_role_binding" "operate_workflow" {
  metadata {
    name = "operate-workflow"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.operate_workflow.metadata[0].name
  }
  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.operate_workflow.metadata[0].name
    namespace = kubernetes_namespace.argo_events.metadata[0].name
  }
}

data "http" "manifestfile" {
  url = "https://raw.githubusercontent.com/argoproj/argo-events/v1.3.1/manifests/install.yaml"
}

resource "kubectl_manifest" "argo_events" {
  for_each = toset(split("---", data.http.manifestfile.body))
  yaml_body = each.value
}
