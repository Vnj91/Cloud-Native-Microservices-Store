# --- USER SERVICE ---
resource "kubernetes_deployment_v1" "user_service" {
  metadata { name = "user-service" }
  spec {
    replicas = 1
    selector { match_labels = { app = "user-service" } }
    template {
      metadata { labels = { app = "user-service" } }
      spec {
        container {
          name  = "user-service"
          image = "vnj91/user-service:latest"
          port { container_port = 8082 }
          
          env {
            name  = "SPRING_DATASOURCE_URL"
            value = "jdbc:postgresql://user-db:5432/userdb"
          }

          # Map Username from Secret
          env {
            name = "SPRING_DATASOURCE_USERNAME"
            value_from {
              secret_key_ref {
                name = "user-db-secret"
                key  = "POSTGRES_USER"
              }
            }
          }

          # Map Password from Secret
          env {
            name = "SPRING_DATASOURCE_PASSWORD"
            value_from {
              secret_key_ref {
                name = "user-db-secret"
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
  metadata { name = "user-service" }
  spec {
    selector = { app = "user-service" }
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
  metadata { name = "product-service" }
  spec {
    replicas = 2 
    selector { match_labels = { app = "product-service" } }
    template {
      metadata { labels = { app = "product-service" } }
      spec {
        container {
          name  = "product-service"
          image = "vnj91/product-service:latest"
          port { container_port = 8081 }

          env {
            name  = "SPRING_DATASOURCE_URL"
            value = "jdbc:postgresql://product-db:5432/productdb"
          }

          # Map Username from Secret (Product DB)
          env {
            name = "SPRING_DATASOURCE_USERNAME"
            value_from {
              secret_key_ref {
                name = "user-db-secret" # Reusing common secret or replace with product-db-secret if different
                key  = "POSTGRES_USER"
              }
            }
          }

          # Map Password from Secret (Product DB)
          env {
            name = "SPRING_DATASOURCE_PASSWORD"
            value_from {
              secret_key_ref {
                name = "user-db-secret"
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
  metadata { name = "product-service" }
  spec {
    selector = { app = "product-service" }
    port {
      port        = 8081
      target_port = 8081
      node_port   = 30081
    }
    type = "NodePort"
  }
}