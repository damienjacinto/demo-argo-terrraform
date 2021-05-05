resource "kubernetes_service_account" "argo_admin" {
  metadata {
    name      = "argo-admin"
    namespace = kubernetes_namespace.argo.metadata[0].name
    annotations = {
      "workflows.argoproj.io/rbac-rule"            = var.argoworkflow_admin_rule
      "workflows.argoproj.io/rbac-rule-precedence" = "100"
    }
  }
}

resource "kubernetes_service_account" "argo_users" {
  metadata {
    name      = "argo-users"
    namespace = kubernetes_namespace.argo.metadata[0].name
    annotations = {
      "workflows.argoproj.io/rbac-rule"            = "true"
      "workflows.argoproj.io/rbac-rule-precedence" = "0"
    }
  }
}

resource "kubernetes_role" "argo_admin" {
  metadata {
    name      = "argo-admin"
    namespace = kubernetes_namespace.argo.metadata[0].name
  }
  rule {
    api_groups = [""]
    resources  = ["configmaps", "events"]
    verbs      = ["get", "list", "watch"]
  }
  rule {
    api_groups = [""]
    resources  = ["pods", "pods/exec", "pods/log"]
    verbs      = ["get", "list", "watch", "delete"]
  }
  rule {
    api_groups     = [""]
    resource_names = ["sso"]
    resources      = ["secrets"]
    verbs          = ["get", "update"]
  }
  rule {
    api_groups = [""]
    resources  = ["secrets"]
    verbs      = ["create"]
  }
  rule {
    api_groups = [""]
    resources  = ["secrets"]
    verbs      = ["create"]
  }
  rule {
    api_groups = [""]
    resources  = ["serviceaccounts"]
    verbs      = ["get", "list"]
  }
  rule {
    api_groups = [""]
    resources  = ["secrets"]
    verbs      = ["get"]
  }
  rule {
    api_groups = [""]
    resources  = ["events"]
    verbs      = ["watch"]
  }
  rule {
    api_groups = ["argoproj.io"]
    resources  = ["workflows", "workfloweventbindings", "workflowtemplates", "cronworkflows", "cronworkflows/finalizers", "clusterworkflowtemplates"]
    verbs      = ["create", "get", "list", "watch", "update", "patch", "delete"]
  }
}

resource "kubernetes_role" "argo_users" {
  metadata {
    name      = "argo-users"
    namespace = kubernetes_namespace.argo.metadata[0].name
  }
  rule {
    api_groups = [""]
    resources  = ["configmaps", "events"]
    verbs      = ["get", "list", "watch"]
  }
  rule {
    api_groups = [""]
    resources  = ["pods", "pods/exec", "pods/log"]
    verbs      = ["get", "list", "watch", "delete"]
  }
  rule {
    api_groups     = [""]
    resource_names = ["sso"]
    resources      = ["secrets"]
    verbs          = ["get", "update"]
  }
  rule {
    api_groups = [""]
    resources  = ["secrets"]
    verbs      = ["create"]
  }
  rule {
    api_groups = [""]
    resources  = ["secrets"]
    verbs      = ["create"]
  }
  rule {
    api_groups = [""]
    resources  = ["serviceaccounts"]
    verbs      = ["get", "list"]
  }
  rule {
    api_groups = [""]
    resources  = ["secrets"]
    verbs      = ["get"]
  }
  rule {
    api_groups = [""]
    resources  = ["events"]
    verbs      = ["watch"]
  }
  rule {
    api_groups = ["argoproj.io"]
    resources  = ["workfloweventbindings", "workflowtemplates", "cronworkflows", "cronworkflows/finalizers", "clusterworkflowtemplates"]
    verbs      = ["get", "list", "watch", "update", "patch"]
  }
  rule {
    api_groups = ["argoproj.io"]
    resources  = ["workflows"]
    verbs      = ["get", "list", "watch", "update", "patch", "create"]
  }
}

resource "kubernetes_cluster_role" "argo_admin" {
  metadata {
    name = "argo-admin"
  }
  rule {
    api_groups = ["argoproj.io"]
    resources  = ["workflows", "workfloweventbindings", "workflowtemplates", "cronworkflows", "cronworkflows/finalizers", "clusterworkflowtemplates"]
    verbs      = ["create", "get", "list", "watch", "update", "patch", "delete"]
  }
}

resource "kubernetes_cluster_role" "argo_users" {
  metadata {
    name = "argo-users"
  }
  rule {
    api_groups = ["argoproj.io"]
    resources  = ["workflows", "workfloweventbindings", "workflowtemplates", "cronworkflows", "cronworkflows/finalizers", "clusterworkflowtemplates"]
    verbs      = ["get", "list", "watch", "update", "patch"]
  }
}

resource "kubernetes_role_binding" "argo_admin" {
  metadata {
    name      = "argo-admin"
    namespace = kubernetes_namespace.argo.metadata[0].name
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = kubernetes_role.argo_admin.metadata[0].name
  }
  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.argo_admin.metadata[0].name
    namespace = kubernetes_namespace.argo.metadata[0].name
  }
}

resource "kubernetes_role_binding" "argo_users" {
  metadata {
    name      = "argo-users"
    namespace = kubernetes_namespace.argo.metadata[0].name
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = kubernetes_role.argo_users.metadata[0].name
  }
  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.argo_users.metadata[0].name
    namespace = kubernetes_namespace.argo.metadata[0].name
  }
}

resource "kubernetes_cluster_role_binding" "argo_admin" {
  metadata {
    name = "argo-admin"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.argo_admin.metadata[0].name
  }
  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.argo_admin.metadata[0].name
    namespace = kubernetes_namespace.argo.metadata[0].name
  }
}

resource "kubernetes_cluster_role_binding" "argo_users" {
  metadata {
    name = "argo-users"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.argo_admin.metadata[0].name
  }
  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.argo_admin.metadata[0].name
    namespace = kubernetes_namespace.argo.metadata[0].name
  }
}

resource "kubernetes_role" "argo_extra" {
  metadata {
    name      = "argo-extra"
    namespace = kubernetes_namespace.argo.metadata[0].name
  }
  rule {
    api_groups = [""]
    resources  = ["pods", "pods/exec", "pods/log"]
    verbs      = ["get", "list", "watch", "delete"]
  }
}

resource "kubernetes_role_binding" "argo_extra" {
  metadata {
    name      = "argo-extra"
    namespace = kubernetes_namespace.argo.metadata[0].name
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = kubernetes_role.argo_extra.metadata[0].name
  }
  subject {
    kind      = "ServiceAccount"
    name      = "argo"
    namespace = kubernetes_namespace.argo.metadata[0].name
  }
}
