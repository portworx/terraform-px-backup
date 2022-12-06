output "portworx_operator_status" {
  value       = helm_release.portworx[0].metadata[0]
  description = "Portworx Storage Class Parameters"
}

output "portworx_backup_status" {
  value       = var.enable_portworx_backup ? helm_release.portworx_backup[0].metadata[0] : null
  description = "Portworx Backup Parameters"
}
