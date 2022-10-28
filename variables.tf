variable "px_backup_version" {
  type        = string
  description = "(optional) describe your variable"
  default     = "2.3.1"
}

variable "px_version" {
  type        = string
  description = "(optional) describe your variable"
  default     = "2.12.0"
}

variable "px_operator_version" {
  type        = string
  description = "(optional) describe your variable"
  default     = "1.10.0"
}

variable "namespace" {
  type        = string
  description = "(optional) describe your variable"
  default     = "central"
}

variable "kubeconfig_path" {
  type        = string
  description = "(optional) describe your variable"
  default     = "~/.kube/config"
}

variable "kubecontext" {
  type        = string
  description = "(optional) describe your variable"
}

variable "external_oidc_provider" {
  type = object({
    enabled       = bool
    endpoint      = string
    client_id     = string
    client_secret = string
  })
  description = "value"
  default = {
    client_id     = ""
    client_secret = ""
    enabled       = false
    endpoint      = ""
  }
}


variable "custom_image_registry" {
  type = object({
    enabled            = bool
    image_registry     = string
    image_repository   = string
    image_pull_secrets = list(string)
  })
  description = "value"
  default = {
    enabled            = false
    image_pull_secrets = []
    image_repository   = ""
    image_registry     = ""
  }
}
