# --- ORDER SERVICE ---
resource "kubernetes_deployment_v1" "order_service" {
  metadata {
    name = "order-service"
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "order-service"
      }
    }

    template {
      metadata {
        labels = {
          app = "order-service"
        }
      }

      spec {

        # 🔥 INIT CONTAINER (waits for order-db)
        init_container {
          name  = "wait-for-order-db"
          image = "busybox:1.36"

          command = [
            "sh",
            "-c",
            "until nc -z order-db 5432; do echo waiting for order-db; sleep 2; done"
          ]
        }

        # 👇 MAIN CONTAINER
        container {
          name  = "order-service"
          image = "vnj91/order-service:latest"

          port {
            container_port = 8083
          }

          env {
            name  = "SPRING_DATASOURCE_URL"
            value = "jdbc:postgresql://order-db:5432/orderdb"
          }

          env {
            name = "SPRING_DATASOURCE_USERNAME"
            value_from {
              secret_key_ref {
                name = kubernetes_secret_v1.db_secret.metadata[0].name
                key  = "POSTGRES_USER"
              }
            }
          }

          env {
            name = "SPRING_DATASOURCE_PASSWORD"
            value_from {
              secret_key_ref {
                name = kubernetes_secret_v1.db_secret.metadata[0].name
                key  = "POSTGRES_PASSWORD"
              }
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service_v1" "order_service" {
  metadata {
    name = "order-service"
  }

  spec {
    selector = {
      app = "order-service"
    }

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
  metadata {
    name = "api-gateway"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "api-gateway"
      }
    }

    template {
      metadata {
        labels = {
          app = "api-gateway"
        }
      }

      spec {

        # 🔥 INIT CONTAINER (waits for backend services)
        init_container {
          name  = "wait-for-services"
          image = "busybox:1.36"

          command = [
            "sh",
            "-c",
            "until nc -z user-service 8082 && nc -z product-service 8081 && nc -z order-service 8083; do echo waiting for services; sleep 2; done"
          ]
        }

        # 👇 MAIN CONTAINER
        container {
          name  = "api-gateway"
          image = "vnj91/api-gateway:latest"

          port {
            container_port = 8080
          }
        }
      }
    }
  }
}

resource "kubernetes_service_v1" "api_gateway" {
  metadata {
    name = "api-gateway"
  }

  spec {
    selector = {
      app = "api-gateway"
    }

    port {
      port        = 80
      target_port = 8080
    }

    type = "LoadBalancer"
  }
}