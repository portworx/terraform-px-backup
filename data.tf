locals {
  oidc_config                  = var.external_oidc_provider != null ? { "oidc.externalOIDC.enabled" = "true", "oidc.externalOIDC.endpoint" = var.external_oidc_provider.endpoint, "oidc.externalOIDC.clientID" = var.external_oidc_provider.client_id, "oidc.externalOIDC.clientSecret" = var.external_oidc_provider.client_secret } : {}
  custom_image_registry_config = var.custom_image_registry != null ? ["pxcentralApiServerImage", "pxcentralFrontendImage", "pxcentralBackendImage", "pxcentralMiddlewareImage", "postInstallSetupImage", "keycloakBackendImage", "keycloakFrontendImage", "keycloakLoginThemeImage", "keycloakInitContainerImage", "mysqlImage", "pxBackupImage", "mongodbImage", "licenseServerImage", "cortexImage", "cassandraImage", "proxyConfigImage", "consulImage", "dnsmasqImage", "grafanaImage", "prometheusImage", "prometheusConfigReloadrImage", "prometheusOperatorImage", "memcachedMetricsImage", "memcachedIndexImage", "memcachedImage"] : []
  px_monitor_config            = var.px_monitor_config.enable ? { "pxmonitor.enabled" = "true", "installCRDs" = "true", "pxmonitor.pxCentralEndpoint" = var.px_monitor_config.px_central_ui_endpoint } : { "pxmonitor.enabled" = "false" }
  px_backup_custom_image       = var.px_backup_custom_image != null ? ["pxBackupImage"] : []
  eks_install_config           = var.provisioner == "eks" ? { "drives" = "type=gp2,size=200", "kvdbDevice" = "type=gp2,size=100" } : {}
  vcenter_install_config       = var.provisioner == "vcenter" ? { "kvdbDevice" = "/dev/sdb" } : {}
}
