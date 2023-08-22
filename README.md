TEST CI
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.8 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | ~> 2.7.1 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 2.14.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | >= 3.1.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | ~> 2.7.1 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | ~> 2.14.0 |
| <a name="provider_null"></a> [null](#provider\_null) | >= 3.1.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.portworx](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.portworx_backup](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_manifest.storageclass_default](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [null_resource.label_nodes_px_license_server](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.validate_portworx_backup_installation](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.validate_portworx_installation](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_custom_image_registry"></a> [custom\_image\_registry](#input\_custom\_image\_registry) | Configuration for Custom Image Registry: Image Registry, Image Repository, Image Pull Secrets | <pre>object({<br>    image_registry     = string<br>    image_repository   = string<br>    image_pull_secrets = list(string)<br>  })</pre> | `null` | no |
| <a name="input_enable_portworx"></a> [enable\_portworx](#input\_enable\_portworx) | Enable Portworx Storage Cluster | `bool` | `true` | no |
| <a name="input_enable_px_license_server"></a> [enable\_px\_license\_server](#input\_enable\_px\_license\_server) | Enable Portworx License Server | `bool` | `false` | no |
| <a name="input_external_oidc_provider"></a> [external\_oidc\_provider](#input\_external\_oidc\_provider) | Configuration for external OIDC Provider: Endpoint, Client ID and Client Secret | <pre>object({<br>    endpoint      = string<br>    client_id     = string<br>    client_secret = string<br>  })</pre> | `null` | no |
| <a name="input_external_storage_class_name"></a> [external\_storage\_class\_name](#input\_external\_storage\_class\_name) | Name of the already existing Storage Class to be used in-place of `portworx_storage_class_config` | `string` | `""` | no |
| <a name="input_kubecontext"></a> [kubecontext](#input\_kubecontext) | Name of the kubecontext | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace to deploy PX-Central | `string` | `"central"` | no |
| <a name="input_portworx_storage_class_config"></a> [portworx\_storage\_class\_config](#input\_portworx\_storage\_class\_config) | Configuration for Default Portworx Storage Class: Name, Replications, Provisioner | <pre>object({<br>    name        = string<br>    replication = number<br>    provisioner = string<br>  })</pre> | `null` | no |
| <a name="input_px_backup_version"></a> [px\_backup\_version](#input\_px\_backup\_version) | Portworx Backup Image Version | `string` | `"2.3.1"` | no |
| <a name="input_px_monitor_config"></a> [px\_monitor\_config](#input\_px\_monitor\_config) | Configuration for Portworx Monitor: enable, Px-Central UI's Endpoint | <pre>object({<br>    enable                 = bool<br>    px_central_ui_endpoint = string<br>  })</pre> | <pre>{<br>  "enable": false,<br>  "px_central_ui_endpoint": ""<br>}</pre> | no |
| <a name="input_px_operator_version"></a> [px\_operator\_version](#input\_px\_operator\_version) | Portworx Operator Image Version | `string` | `"1.10.0"` | no |
| <a name="input_px_version"></a> [px\_version](#input\_px\_version) | Portworx Image Version (OCI Monitor Image) | `string` | `"2.12.0"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_portworx_backup_status"></a> [portworx\_backup\_status](#output\_portworx\_backup\_status) | value |
| <a name="output_portworx_operator_status"></a> [portworx\_operator\_status](#output\_portworx\_operator\_status) | value |
