# --- USER DATABASE ---
resource "kubernetes_deployment_v1" "user_db" {
  metadata { name = "user-db" }
  spec {
    replicas = 1
    selector { match_labels = { app = "user-db" } }
    template {
      metadata { labels = { app = "user-db" } }
      spec {
        container {
          name  = "postgres"
          image = "postgres:15"
          port { container_port = 5432 }
          env {
            name = "POSTGRES_DB"
            value = "userdb"
          }
          env {
            name = "POSTGRES_USER"
            value_from {
              secret_key_ref {
                name = "user-db-secret"
                key  = "POSTGRES_USER"
              }
            }
          }
          env {
            name = "POSTGRES_PASSWORD"
            value_from {
              secret_key_ref {
                name = "user-db-secret"
                key  = "POSTGRES_PASSWORD"
              }
            }
          }
          volume_mount {
            name       = "user-db-storage"
            mount_path = "/var/lib/postgresql/data"
          }
        }
        volume {
          name = "user-db-storage"
          persistent_volume_claim {
            claim_name = "user-db-pvc"
          }
        }
      }
    }
  }
}

resource "kubernetes_service_v1" "user_db" {
  metadata { name = "user-db" }
  spec {
    selector = { app = "user-db" }
    port {
      port        = 5432
      target_port = 5432
    }
    type = "ClusterIP"
  }
}

# --- PRODUCT DATABASE ---
resource "kubernetes_deployment_v1" "product_db" {
  metadata { name = "product-db" }
  spec {
    replicas = 1
    selector { match_labels = { app = "product-db" } }
    template {
      metadata { labels = { app = "product-db" } }
      spec {
        container {
          name  = "postgres"
          image = "postgres:15"
          port { container_port = 5432 }
          env {
            name = "POSTGRES_DB"
            value = "productdb"
          }
          env {
            name = "POSTGRES_USER"
            value_from {
              secret_key_ref {
                name = "user-db-secret"
                key  = "POSTGRES_USER"
              }
            }
          }
          env {
            name = "POSTGRES_PASSWORD"
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

resource "kubernetes_service_v1" "product_db" {
  metadata { name = "product-db" }
  spec {
    selector = { app = "product-db" }
    port {
      port        = 5432
      target_port = 5432
    }
    type = "ClusterIP"
  }
}