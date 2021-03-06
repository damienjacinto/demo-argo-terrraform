terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.0.2"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.9.4"
    }
  }
  required_version = ">= 0.14"
}
