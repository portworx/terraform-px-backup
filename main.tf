resource "null_resource" "validate_portworx_installation" {
  provisioner "local-exec" {
    command     = "bash portworx_wait_untill_ready.sh"
    working_dir = "${path.module}/utils"
    interpreter = ["/bin/bash", "-c"]
    on_failure  = fail
  }
  depends_on = [
    helm_release.portworx
  ]
}

resource "null_resource" "validate_portworx_backup_installation" {
  triggers = {
    license_server = var.enable_px_license_server,
    monitor        = var.px_monitor_config.enable,
    backup         = var.px_backup_version,
    namespace      = var.namespace
  }
  provisioner "local-exec" {
    command     = "bash portworx_backup_validation.sh ${self.triggers.namespace} ${var.wait_for_px_central}"
    working_dir = "${path.module}/utils"
    interpreter = ["/bin/bash", "-c"]
    on_failure  = fail
  }
  depends_on = [
    helm_release.portworx_backup
  ]
}

resource "null_resource" "label_nodes_px_license_server" {
  count = var.enable_px_license_server ? 1 : 0
  provisioner "local-exec" {
    command    = "kubectl get nodes | grep -v 'control-plane\\|master' | awk 'NR>1 { print $1 }' | head -n 2 | xargs -I {} kubectl label node {} px/ls=true"
    on_failure = fail
  }
  provisioner "local-exec" {
    when    = destroy
    command = "kubectl label node --all px/ls-"
  }
}

resource "helm_release" "portworx" {
  count      = var.enable_portworx ? 1 : 0
  name       = "portworx"
  repository = "https://raw.githubusercontent.com/portworx/eks-blueprint-helm/main/repo/stable"
  chart      = "portworx"
  version    = "2.11.0"

  set {
    name  = "imageVersion"
    value = var.px_version
  }

  set {
    name  = "pxOperatorImageVersion"
    value = var.px_operator_version
  }

  set {
    name  = "clusterName"
    value = "px-cluster"
  }

  set {
    name  = "internalKVDB"
    value = true
  }

  set {
    name  = "kvdbDevice"
    value = "/dev/sdb"
  }

  set {
    name  = "deleteStrategy.type"
    value = "UninstallAndWipe"
  }

  set {
    name  = "aut"
    value = var.enable_autopilot ? true : false
  }
}


resource "kubernetes_manifest" "storageclass_default" {
  count = var.portworx_storage_class_config != null ? 1 : 0
  manifest = {
    "allowVolumeExpansion" = true
    "apiVersion"           = "storage.k8s.io/v1"
    "kind"                 = "StorageClass"
    "metadata" = {
      "name" = var.portworx_storage_class_config.name
    }
    "parameters" = {
      "repl" = tostring(var.portworx_storage_class_config.replication)
    }
    "provisioner"       = var.portworx_storage_class_config.provisioner
    "reclaimPolicy"     = "Delete"
    "volumeBindingMode" = "Immediate"
  }
}

resource "helm_release" "portworx_backup" {
  count            = var.enable_portworx_backup ? 1 : 0
  name             = "px-central"
  repository       = "https://raw.githubusercontent.com/portworx/helm/master/stable"
  chart            = "px-central"
  version          = var.px_backup_version
  namespace        = var.namespace
  create_namespace = true
  wait             = false

  set {
    name  = "persistentStorage.enabled"
    value = true
  }

  set {
    name  = "persistentStorage.storageClassName"
    value = var.portworx_storage_class_config != null ? var.portworx_storage_class_config.name : var.external_storage_class_name
  }
  set {
    name  = "pxbackup.enabled"
    value = true
  }

  set {
    name  = "pxlicenseserver.enabled"
    value = var.enable_px_license_server
  }

  dynamic "set" {
    for_each = local.px_monitor_config
    iterator = params
    content {
      name  = params.key
      value = params.value
    }
  }

  dynamic "set" {
    for_each = local.oidc_config
    iterator = params
    content {
      name  = params.key
      value = params.value
    }
  }

  dynamic "set" {
    for_each = local.custom_image_registry_config
    iterator = params
    content {
      name  = "image.${params.value}.repo"
      value = var.custom_image_registry.image_repository
    }
  }

  dynamic "set" {
    for_each = local.custom_image_registry_config
    iterator = params
    content {
      name  = "image.${params.value}.registry"
      value = var.custom_image_registry.image_registry
    }
  }

  dynamic "set" {
    for_each = var.custom_image_registry != null ? var.custom_image_registry.image_pull_secrets : []
    iterator = secret
    content {
      name  = "images.pullSecrets[${secret.key}]"
      value = secret.value
    }
  }

  depends_on = [
    null_resource.validate_portworx_installation,
    kubernetes_manifest.storageclass_default,
    null_resource.label_nodes_px_license_server
  ]
}
