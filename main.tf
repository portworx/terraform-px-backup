resource "helm_release" "portworx" {
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
    value = true
  }
}
resource "null_resource" "validate_portworx_installation" {
  provisioner "local-exec" {
    command     = "bash portworx_wait_untill_ready.sh"
    working_dir = "${path.module}/utils"
    interpreter = ["/bin/bash", "-c"]
  }
  depends_on = [
    helm_release.portworx
  ]
}

resource "kubernetes_manifest" "storageclass_default" {
  manifest = {
    "allowVolumeExpansion" = true
    "apiVersion"           = "storage.k8s.io/v1"
    "kind"                 = "StorageClass"
    "metadata" = {
      "name" = "px-default"
    }
    "parameters" = {
      "repl" = "1"
    }
    "provisioner"       = "kubernetes.io/portworx-volume"
    "reclaimPolicy"     = "Delete"
    "volumeBindingMode" = "Immediate"
  }
}


resource "helm_release" "portworx_backup" {
  name             = "px-central"
  repository       = "http://charts.portworx.io/"
  chart            = "px-central"
  version          = var.px_backup_version
  namespace        = var.namespace
  create_namespace = true

  set {
    name  = "persistentStorage.enabled"
    value = true
  }
  set {
    name  = "persistentStorage.storageClassName"
    value = "px-default"
  }
  set {
    name  = "pxbackup.enabled"
    value = true
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
    for_each = var.custom_image_registry.image_pull_secrets
    iterator = secret
    content {
      name  = "images.pullSecrets[${secret.key}]"
      value = secret.value
    }
  }
  depends_on = [
    null_resource.validate_portworx_installation,
    kubernetes_manifest.storageclass_default
  ]
}
