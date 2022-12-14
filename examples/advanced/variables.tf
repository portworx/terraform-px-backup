variable "px_backup_version" {
  type        = string
  description = "Portworx Backup Image Version"
  default     = "2.3.1"
}

variable "px_version" {
  type        = string
  description = "Portworx Image Version (OCI Monitor Image)"
  default     = "2.11.0"
}

variable "px_operator_version" {
  type        = string
  description = "Portworx Operator Image Version"
  default     = "1.10.0"
}

variable "namespace" {
  type        = string
  description = "Namespace to deploy PX-Central"
  default     = "central"
}

variable "kubeconfig_path" {
  type        = string
  description = "Path to the kubeconfig to connect to the kubernetes cluster"
  default     = "~/.kube/config"
}

variable "enable_px_license_server" {
  type        = bool
  description = "Enable Portworx License Server"
  default     = false
}

variable "enable_portworx" {
  type        = bool
  description = "Enable Portworx Storage Cluster"
  default     = true
}

variable "external_oidc_provider" {
  type = object({
    endpoint      = string
    client_id     = string
    client_secret = string
  })
  description = "Configuration for external OIDC Provider: Endpoint, Client ID and Client Secret"
  default     = null
}

variable "custom_image_registry" {
  type = object({
    image_registry     = string
    image_repository   = string
    image_pull_secrets = list(string)
  })
  description = "Configuration for Custom Image Registry: Image Registry, Image Repository, Image Pull Secrets"
  default     = null
}

variable "portworx_storage_class_config" {
  type = object({
    name        = string
    replication = number
    provisioner = string
  })
  description = "Configuration for Default Portworx Storage Class: Name, Replications, Provisioner"
  default     = null
}
variable "px_monitor_config" {
  type = object({
    enable                 = bool
    px_central_ui_endpoint = string
  })
  description = "Configuration for Portworx Monitor: enable, Px-Central UI's Endpoint"
  default = {
    enable                 = false
    px_central_ui_endpoint = ""
  }
}
variable "external_storage_class_name" {
  type        = string
  description = "Name of the already existing Storage Class to be used in-place of `portworx_storage_class_config`"
  default     = ""
}
variable "enable_portworx_backup" {
  type        = bool
  description = "Enable Portworx Backup"
  default     = true
}

variable "stork_version" {
  type        = string
  description = "Version of stork to be deployed"
  default     = ""
}
