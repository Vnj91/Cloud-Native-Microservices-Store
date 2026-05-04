# --- ORDER SERVICE ---
resource "kubernetes_deployment_v1" "order_service" {
  metadata { name = "order-service" }
  spec {
    replicas = 2
    selector { match_labels = { app = "order-service" } }
    template {
      metadata { labels = { app = "order-service" } }
      spec {
        container {
          name  = "order-service"
          image = "vnj91/order-service:latest"
          port { container_port = 8083 }
          env {
            name  = "SPRING_DATASOURCE_URL"
            value = "jdbc:postgresql://order-db:5432/orderdb"
          }
        }
      }
    }
  }
}

resource "kubernetes_service_v1" "order_service" {
  metadata { name = "order-service" }
  spec {
    selector = { app = "order-service" }
    port {
      port        = 8083
      target_port = 8083
      node_port   = 30083
    }
    type = "NodePort"
  }
}

# --- API GATEWAY ---
resource "kubernetes_deployment_v1" "api_gateway" {
  metadata { name = "api-gateway" }
  spec {
    replicas = 1
    selector { match_labels = { app = "api-gateway" } }
    template {
      metadata { labels = { app = "api-gateway" } }
      spec {
        container {
          name  = "api-gateway"
          image = "vnj91/api-gateway:latest"
          port { container_port = 8080 }
        }
      }
    }
  }
}

resource "kubernetes_service_v1" "api_gateway" {
  metadata { name = "api-gateway" }
  spec {
    selector = { app = "api-gateway" }
    port {
      port        = 80
      target_port = 8080
    }
    type = "LoadBalancer"
  }
}