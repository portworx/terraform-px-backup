output "installation_status" {
  value       = { px_backup_status = module.portworx_backup.portworx_backup_status }
  description = "Portworx Backup Status"
}
