variable "KUBERNETES_CONFIG_PATH" {
  type        = string
  description = "kubernetes config path"
  sensitive   = true
}

variable "AUTH_ISSUER" {
  type        = string
  description = "auth0 client issuer"
  sensitive   = true
}

variable "AUTH_CLIENTID" {
  type        = string
  description = "auth0 client id"
  sensitive   = true
}

variable "AUTH_CLIENTSECRET" {
  type        = string
  description = "auth0 client secret"
  sensitive   = true
}

variable "SLACK_TOKEN" {
  type        = string
  description = "slack token"
  sensitive   = true
}

variable "GITHUB_SECRET" {
  type        = string
  description = "github secret"
  sensitive   = true
}

variable "GITHUB_TOKEN" {
  type        = string
  description = "github token"
  sensitive   = true
}

variable "GITHUB_USERNAME" {
  type        = string
  description = "github username"
  sensitive   = true
}

variable "SLACK_DEPLOY_SECRET" {
  type        = string
  description = "slack command deploy secret"
  sensitive   = true
}

variable "SLACK_SIGNIN_SECRET" {
  type        = string
  description = "slack command signin secret"
  sensitive   = true
}

