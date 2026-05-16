# --- FRONTEND ---
resource "kubernetes_deployment_v1" "frontend" {
  metadata {
    name = "frontend"
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "frontend"
      }
    }
    template {
      metadata {
        labels = {
          app = "frontend"
        }
      }
      spec {
        container {
          name  = "frontend"
          image = "${var.docker_hub_username}/frontend:latest"
          port {
            container_port = 80
          }
          env {
            name  = "VITE_API_BASE"
            value = "http://api-gateway:8080/api"
          }
        }
      }
    }
  }
}

resource "kubernetes_service_v1" "frontend_service" {
  metadata {
    name = "frontend"
  }
  spec {
    selector = {
      app = "frontend"
    }
    port {
      port        = 80
      target_port = 80
      node_port   = 30000
    }
    type = "NodePort"
  }
}