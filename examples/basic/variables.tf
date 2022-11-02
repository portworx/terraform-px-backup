variable "px_backup_version" {
  type        = string
  description = "Portworx Backup Image Version"
  default     = "2.3.1"
}

variable "px_version" {
  type        = string
  description = "Portworx Image Version (OCI Monitor Image)"
  default     = "2.12.0"
}

variable "px_operator_version" {
  type        = string
  description = "Portworx Operator Image Version"
  default     = "1.10.0"
}

variable "kubecontext" {
  type        = string
  description = "Name of the kubecontext"
}

variable "kubeconfig_path" {
  type        = string
  description = "Path to the kubeconfig to connect to the kubernetes cluster"
  default     = "~/.kube/config"
}
