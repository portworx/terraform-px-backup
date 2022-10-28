provider "kubernetes" {
  config_path    = var.kubeconfig_path
  config_context = var.kubecontext
}


provider "helm" {
  kubernetes {
    config_path = var.kubeconfig_path
  }
}

provider "kubectl" {
  config_path    = var.kubeconfig_path
  config_context = var.kubecontext
}
