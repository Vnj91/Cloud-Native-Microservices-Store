# =========================
# ORDER SERVICE
# =========================

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

        # INIT CONTAINER - wait for DB
        init_container {
          name  = "wait-for-order-db"
          image = "busybox:1.36"

          command = [
            "sh",
            "-c",
            "until nc order-db 5432; do echo waiting for order-db; sleep 2; done"
          ]
        }

        container {
          name  = "order-service"
          image = "${var.docker_hub_username}/order-service:latest"

          port {
            container_port = 8083
          }

          env {
            name  = "SPRING_DATASOURCE_URL"
            value = "jdbc:postgresql://order-db:5432/orderdb"
          }

          env {
            name  = "EUREKA_CLIENT_SERVICEURL_DEFAULTZONE"
            value = "http://discovery-service:8761/eureka"
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


# =========================
# API GATEWAY
# =========================

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

        # REMOVED problematic init container

        container {
          name  = "api-gateway"
          image = "${var.docker_hub_username}/api-gateway:latest"

          port {
            container_port = 8080
          }

          env {
            name  = "EUREKA_CLIENT_SERVICEURL_DEFAULTZONE"
            value = "http://discovery-service:8761/eureka"
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