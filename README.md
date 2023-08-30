# Terraform Module for Portworx Backup

This terraform module helps you provision Portworx Backup on Kubernetes Clusters.This repository hosts the terraform module which can be used in conjunction with existing terraform scripts to provision Portworx Backup on Kubernetes.

## Getting Started

This guide is intended to provide a quick start to users who want to manage Portworx Backup Installation on their existing Kubernetes Clusters using Terraform.

## Pre-requisites

- Terraform >= 0.13
- Already Provisioned Kubernetes Cluster
- `kubectl` installed and pointed to the correct Kubernetes Cluster
- `jq`, `curl`, `wget` installed on the local machine

## Examples

The below hyperlinks guide you to understand and demonstrate the features and capabilities of this Terraform module:

- [Basic](https://github.com/portworx/terraform-px-backup/tree/main/examples/basic)
- [Advanced](https://github.com/portworx/terraform-px-backup/tree/main/examples/advanced)

## Requirements

| Name                                                                        | Version   |
| --------------------------------------------------------------------------- | --------- |
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform)    | >= 1.2.8  |
| <a name="requirement_helm"></a> [helm](#requirement_helm)                   | ~> 2.7.1  |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement_kubernetes) | ~> 2.14.0 |
| <a name="requirement_null"></a> [null](#requirement_null)                   | >= 3.1.1  |

## Providers

| Name                                                                  | Version   |
| --------------------------------------------------------------------- | --------- |
| <a name="provider_helm"></a> [helm](#provider_helm)                   | ~> 2.7.1  |
| <a name="provider_kubernetes"></a> [kubernetes](#provider_kubernetes) | ~> 2.14.0 |
| <a name="provider_null"></a> [null](#provider_null)                   | >= 3.1.1  |

## Modules

No modules.

## Resources

| Name                                                                                                                                         | Type     |
| -------------------------------------------------------------------------------------------------------------------------------------------- | -------- |
| [helm_release.portworx](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release)                                | resource |
| [helm_release.portworx_backup](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release)                         | resource |
| [kubernetes_manifest.storageclass_default](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest)      | resource |
| [null_resource.label_nodes_px_license_server](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource)         | resource |
| [null_resource.validate_portworx_backup_installation](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.validate_portworx_installation](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource)        | resource |

## Inputs

| Name                                                                                                                     | Description                                                                                       | Type                                                                                                                       | Default                                                                 | Required |
| ------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------- | :------: |
| <a name="input_custom_image_registry"></a> [custom_image_registry](#input_custom_image_registry)                         | Configuration for Custom Image Registry: Image Registry, Image Repository, Image Pull Secrets     | <pre>object({<br> image_registry = string<br> image_repository = string<br> image_pull_secrets = list(string)<br> })</pre> | `null`                                                                  |    no    |
| <a name="input_enable_portworx"></a> [enable_portworx](#input_enable_portworx)                                           | Enable Portworx Storage Cluster                                                                   | `bool`                                                                                                                     | `true`                                                                  |    no    |
| <a name="input_enable_px_license_server"></a> [enable_px_license_server](#input_enable_px_license_server)                | Enable Portworx License Server                                                                    | `bool`                                                                                                                     | `false`                                                                 |    no    |
| <a name="input_external_oidc_provider"></a> [external_oidc_provider](#input_external_oidc_provider)                      | Configuration for external OIDC Provider: Endpoint, Client ID and Client Secret                   | <pre>object({<br> endpoint = string<br> client_id = string<br> client_secret = string<br> })</pre>                         | `null`                                                                  |    no    |
| <a name="input_external_storage_class_name"></a> [external_storage_class_name](#input_external_storage_class_name)       | Name of the already existing Storage Class to be used in-place of `portworx_storage_class_config` | `string`                                                                                                                   | `""`                                                                    |    no    |
| <a name="input_kubecontext"></a> [kubecontext](#input_kubecontext)                                                       | Name of the kubecontext                                                                           | `string`                                                                                                                   | n/a                                                                     |   yes    |
| <a name="input_namespace"></a> [namespace](#input_namespace)                                                             | Namespace to deploy PX-Central                                                                    | `string`                                                                                                                   | `"central"`                                                             |    no    |
| <a name="input_portworx_storage_class_config"></a> [portworx_storage_class_config](#input_portworx_storage_class_config) | Configuration for Default Portworx Storage Class: Name, Replications, Provisioner                 | <pre>object({<br> name = string<br> replication = number<br> provisioner = string<br> })</pre>                             | `null`                                                                  |    no    |
| <a name="input_px_backup_version"></a> [px_backup_version](#input_px_backup_version)                                     | Portworx Backup Image Version                                                                     | `string`                                                                                                                   | `"2.3.1"`                                                               |    no    |
| <a name="input_px_monitor_config"></a> [px_monitor_config](#input_px_monitor_config)                                     | Configuration for Portworx Monitor: enable, Px-Central UI's Endpoint                              | <pre>object({<br> enable = bool<br> px_central_ui_endpoint = string<br> })</pre>                                           | <pre>{<br> "enable": false,<br> "px_central_ui_endpoint": ""<br>}</pre> |    no    |
| <a name="input_px_operator_version"></a> [px_operator_version](#input_px_operator_version)                               | Portworx Operator Image Version                                                                   | `string`                                                                                                                   | `"1.10.0"`                                                              |    no    |
| <a name="input_px_version"></a> [px_version](#input_px_version)                                                          | Portworx Image Version (OCI Monitor Image)                                                        | `string`                                                                                                                   | `"2.12.0"`                                                              |    no    |

## Outputs

| Name                                                                                                        | Description |
| ----------------------------------------------------------------------------------------------------------- | ----------- |
| <a name="output_portworx_backup_status"></a> [portworx_backup_status](#output_portworx_backup_status)       | value       |
| <a name="output_portworx_operator_status"></a> [portworx_operator_status](#output_portworx_operator_status) | value       |

## License

Apache License 2.0 - Copyright 2023 Pure Storage, Inc.
