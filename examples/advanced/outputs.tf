output "installation_status" {
  value       = module.portworx_backup.portworx_backup_status
  description = "Portworx Backup Status"
}
