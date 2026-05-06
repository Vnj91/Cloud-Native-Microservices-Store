# --- USER SERVICE ---
resource "kubernetes_deployment_v1" "user_service" {
  metadata {
    name = "user-service"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "user-service"
      }
    }

    template {
      metadata {
        labels = {
          app = "user-service"
        }
      }

      spec {

        # 🔥 INIT CONTAINER (waits for DB)
        init_container {
          name  = "wait-for-user-db"
          image = "busybox:1.36"

          command = [
            "sh",
            "-c",
            "until nc -z user-db 5432; do echo waiting for user-db; sleep 2; done"
          ]
        }

        # 👇 MAIN APP CONTAINER
        container {
          name  = "user-service"
          image = "vnj91/user-service:latest"

          port {
            container_port = 8082
          }

          env {
            name  = "SPRING_DATASOURCE_URL"
            value = "jdbc:postgresql://user-db:5432/userdb"
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

resource "kubernetes_service_v1" "user_service" {
  metadata {
    name = "user-service"
  }

  spec {
    selector = {
      app = "user-service"
    }

    port {
      port        = 8082
      target_port = 8082
      node_port   = 30082
    }

    type = "NodePort"
  }
}


# --- PRODUCT SERVICE ---
resource "kubernetes_deployment_v1" "product_service" {
  metadata {
    name = "product-service"
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "product-service"
      }
    }

    template {
      metadata {
        labels = {
          app = "product-service"
        }
      }

      spec {

        # 🔥 INIT CONTAINER (waits for DB)
        init_container {
          name  = "wait-for-product-db"
          image = "busybox:1.36"

          command = [
            "sh",
            "-c",
            "until nc -z product-db 5432; do echo waiting for product-db; sleep 2; done"
          ]
        }

        # 👇 MAIN APP CONTAINER
        container {
          name  = "product-service"
          image = "vnj91/product-service:latest"

          port {
            container_port = 8081
          }

          env {
            name  = "SPRING_DATASOURCE_URL"
            value = "jdbc:postgresql://product-db:5432/productdb"
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

resource "kubernetes_service_v1" "product_service" {
  metadata {
    name = "product-service"
  }

  spec {
    selector = {
      app = "product-service"
    }

    port {
      port        = 8081
      target_port = 8081
      node_port   = 30081
    }

    type = "NodePort"
  }
}