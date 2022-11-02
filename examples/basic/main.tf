module "portworx_backup" {
  source              = "../../"
  px_backup_version   = var.px_backup_version
  px_version          = var.px_version
  px_operator_version = var.px_operator_version
  kubecontext         = var.kubecontext
}
