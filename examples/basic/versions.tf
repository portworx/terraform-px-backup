terraform {
  required_version = ">= 1.2.8"
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.14.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.4.1"
    }
    null = {
      source  = "hashicorp/null"
      version = ">= 3.1.1"
    }
  }
}
