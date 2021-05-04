variable "argocd_cluster_config_path" {
  type        = string
  description = "kubernetes config path"
  sensitive   = true
}

variable "argocd_version" {
  type        = string
  description = "Argocd chart version"
}

variable "argocd_url" {
  type        = string
  description = "Argocd url"
}

variable "argocd_auth0_issuer" {
  type        = string
  description = "Argocd auth0 issuer"
  sensitive   = true
}

variable "argocd_auth0_clientId" {
  type        = string
  description = "Argocd auth0 issuer"
  sensitive   = true
}

variable "argocd_auth0_clientSecret" {
  type        = string
  description = "Argocd auth0 client secret"
  sensitive   = true
}

variable "argocd_auth0_scopeKey" {
  type        = string
  description = "Argocd auth0 scope key"
  sensitive   = true
}

variable "argo_notification_slack_token" {
  type        = string
  description = "Argo notification slack token"
  sensitive   = true
}

variable "argo_notification_version" {
  type        = string
  description = "Argo notification chart version"
}

variable "argo_notification_icon" {
  type        = string
  description = "Argo notification slack icon"
}

variable "argocd_webhook_github_secret" {
  type        = string
  description = "Argocd github secret"
  sensitive   = true
}

variable "argocd_github_username" {
  type        = string
  description = "Argocd github username"
  sensitive   = true
}

variable "argocd_github_token" {
  type        = string
  description = "Argocd github token"
  sensitive   = true
}

variable "argocd_repositories" {
  type        = list(string)
  description = "Argocd repository list"
  default     = []
}

variable "argocd_projects" {
  type        = list(object({ name = string, description = string, namespace = string, server = string, sourceRepos = string, serverChannel = string }))
  description = "Argocd projects list"
  default     = []
}

variable "argo_events_version" {
  type        = string
  description = "Argocd events version"
}

variable "argoworkflow_url" {
  type        = string
  description = "Argoworkflow url"
}

variable "argoworkflow_image_version" {
  type        = string
  description = "Argoworkflow image version"
}

variable "argoworkflow_version" {
  type        = string
  description = "Argoworkflow chart version"
}

variable "argoworkflow_admin_rule" {
  type        = string
  description = "Argoworkflow admin rule for sso rbac"
}
