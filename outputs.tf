# TODO: Create proper outputs and add descriptions
output "portworx_operator_status" {
  value       = helm_release.portworx[0].metadata[0]
  description = "value"
}

output "portworx_backup_status" {
  value       = helm_release.portworx_backup.metadata[0]
  description = "value"
}
