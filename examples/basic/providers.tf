provider "kubernetes" {
  config_context = var.kubecontext
}


provider "helm" {
  kubernetes {
    config_path = var.kubeconfig_path
  }
}
