# Create the Namespace using the variable
resource "kubernetes_namespace_v1" "practice" {
  metadata {
    name = var.namespace_name
  }
}

# Create the Pod inside that Namespace
resource "kubernetes_pod_v1" "nginx_test" {
  metadata {
    name      = "nginx-practice"
    namespace = kubernetes_namespace_v1.practice.metadata[0].name
    
    labels = {
      app = var.app_label
    }
  }

  spec {
    container {
      image = "nginx:latest"
      name  = "nginx-container"
      
      port {
        container_port = 80
      }
    }
  }
}
