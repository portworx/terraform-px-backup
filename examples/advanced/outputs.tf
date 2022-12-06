output "installation_status" {
  value       = var.enable_portworx_backup ? module.portworx_backup.portworx_backup_status : null
  description = "Portworx Backup Status"
}
