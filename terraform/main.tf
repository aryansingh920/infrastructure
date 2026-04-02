resource "kubernetes_namespace_v1" "practice" {
  metadata {
    name = var.namespace_name
  }
  lifecycle {
    ignore_changes = [metadata]
  }
}

resource "kubernetes_manifest" "nginx_from_yaml" {
  depends_on = [kubernetes_namespace_v1.practice]

  manifest = merge(
    yamldecode(file("${path.module}/../k8s/nginx-deployment.yaml")),
    {
      metadata = merge(
        yamldecode(file("${path.module}/../k8s/nginx-deployment.yaml")).metadata,
        {
          namespace = var.namespace_name
        }
      )
    }
  )
}
