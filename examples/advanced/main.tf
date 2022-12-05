module "portworx_backup" {
  source                        = "../../"
  px_backup_version             = var.px_backup_version
  px_version                    = var.px_version
  px_operator_version           = var.px_operator_version
  namespace                     = var.namespace
  enable_px_license_server      = var.enable_px_license_server
  enable_portworx               = var.enable_portworx
  external_oidc_provider        = var.external_oidc_provider
  custom_image_registry         = var.custom_image_registry
  portworx_storage_class_config = var.portworx_storage_class_config
  px_monitor_config             = var.px_monitor_config
  external_storage_class_name   = var.external_storage_class_name
  wait_for_px_central           = var.wait_for_px_central
  enable_portworx_backup        = var.enable_portworx_backup
}
