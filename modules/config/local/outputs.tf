output "data" {
  value = {
    env                        = "local"
    helm_operator_version      = "1.2.0"
    fluxcd_version             = "1.9.0"
    traefik_version            = "9.19.0"
    argocd_version             = "3.2.2"
    argo_events_version        = "1.3.3"
    argoworkflow_image_version = "v2.12.11"
    argocd_url                 = "argocd.kubernetes.local"
    argoworkflow_url           = "argoworkflow.kubernetes.local"
    argoworkflow_version       = "0.16.7"
    argocd_auth0_scopeKey      = "http://argocd.kubernetes/groups"
    argo_notification_icon     = "https://cdn.pixabay.com/photo/2016/06/29/16/06/potato-1487142_960_720.png"
    argoworkflow_admin_rule    = "email in [\"damien.jacinto@gmail.com\"]"
    argo_notification_version  = "1.2.0"
    argocd_projects = [
      {
        name          = "argo-workflow"
        description   = "Argo workflow installation"
        namespace     = "argo"
        server        = "https://kubernetes.default.svc"
        sourceRepos   = "https://github.com/damienjacinto/demo-argo-workflow"
        serverChannel = "deploy-argo"
      },
      {
        name          = "workflows-template"
        description   = "Workflows template installation"
        namespace     = "argo"
        server        = "https://kubernetes.default.svc"
        sourceRepos   = "https://github.com/damienjacinto/demo-workflows"
        serverChannel = "deploy-argo"
      }
    ]
  }
}
