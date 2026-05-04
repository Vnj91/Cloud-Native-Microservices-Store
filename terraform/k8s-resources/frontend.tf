resource "kubernetes_deployment_v1" "frontend" {
  metadata {
    name = "frontend"
  }
  spec {
    replicas = 1
    selector { match_labels = { app = "frontend" } }
    template {
      metadata { labels = { app = "frontend" } }
      spec {
        container {
          name  = "frontend"
          image = "vnj91/frontend:latest"
          port { container_port = 80 }
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
    selector = { app = "frontend" }
    port {
      port        = 80
      target_port = 80
      node_port   = 30001
    }
    type = "NodePort"
  }
}