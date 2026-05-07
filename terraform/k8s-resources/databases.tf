# =========================
# USER DB STORAGE
# =========================

resource "kubernetes_persistent_volume_v1" "user_db_pv" {
  metadata {
    name = "user-db-pv"
  }

  spec {
    capacity = {
      storage = "1Gi"
    }

    access_modes = ["ReadWriteOnce"]

    persistent_volume_source {
      host_path {
        path = "/mnt/data/user-db"
      }
    }
  }
}

resource "kubernetes_persistent_volume_claim_v1" "user_db_pvc" {
  metadata {
    name = "user-db-pvc"
  }

  spec {
    access_modes = ["ReadWriteOnce"]

    resources {
      requests = {
        storage = "1Gi"
      }
    }
  }
}

# =========================
# USER DB
# =========================

resource "kubernetes_deployment_v1" "user_db" {
  metadata {
    name = "user-db"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "user-db"
      }
    }

    template {
      metadata {
        labels = {
          app = "user-db"
        }
      }

      spec {
        container {
          name  = "postgres"
          image = "postgres:15"

          port {
            container_port = 5432
          }

          env {
            name  = "POSTGRES_DB"
            value = "userdb"
          }

          env {
            name = "POSTGRES_USER"

            value_from {
              secret_key_ref {
                name = kubernetes_secret_v1.db_secret.metadata[0].name
                key  = "POSTGRES_USER"
              }
            }
          }

          env {
            name = "POSTGRES_PASSWORD"

            value_from {
              secret_key_ref {
                name = kubernetes_secret_v1.db_secret.metadata[0].name
                key  = "POSTGRES_PASSWORD"
              }
            }
          }

          volume_mount {
            name       = "user-db-storage"
            mount_path = "/var/lib/postgresql/data"
          }

          readiness_probe {
            exec {
              command = ["pg_isready", "-U", "postgres"]
            }

            initial_delay_seconds = 10
            period_seconds        = 5
          }

          liveness_probe {
            exec {
              command = ["pg_isready", "-U", "postgres"]
            }

            initial_delay_seconds = 20
            period_seconds        = 10
          }

          resources {
            limits = {
              cpu    = "500m"
              memory = "512Mi"
            }

            requests = {
              cpu    = "250m"
              memory = "256Mi"
            }
          }
        }

        volume {
          name = "user-db-storage"

          persistent_volume_claim {
            claim_name = kubernetes_persistent_volume_claim_v1.user_db_pvc.metadata[0].name
          }
        }
      }
    }
  }

  depends_on = [
    kubernetes_persistent_volume_v1.user_db_pv,
    kubernetes_persistent_volume_claim_v1.user_db_pvc
  ]
}

# =========================
# PRODUCT DB
# =========================

resource "kubernetes_deployment_v1" "product_db" {
  metadata {
    name = "product-db"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "product-db"
      }
    }

    template {
      metadata {
        labels = {
          app = "product-db"
        }
      }

      spec {
        container {
          name  = "postgres"
          image = "postgres:15"

          port {
            container_port = 5432
          }

          env {
            name  = "POSTGRES_DB"
            value = "productdb"
          }

          env {
            name = "POSTGRES_USER"

            value_from {
              secret_key_ref {
                name = kubernetes_secret_v1.db_secret.metadata[0].name
                key  = "POSTGRES_USER"
              }
            }
          }

          env {
            name = "POSTGRES_PASSWORD"

            value_from {
              secret_key_ref {
                name = kubernetes_secret_v1.db_secret.metadata[0].name
                key  = "POSTGRES_PASSWORD"
              }
            }
          }

          readiness_probe {
            exec {
              command = ["pg_isready"]
            }

            initial_delay_seconds = 10
          }
        }
      }
    }
  }
}

# =========================
# ORDER DB
# =========================

resource "kubernetes_deployment_v1" "order_db" {
  metadata {
    name = "order-db"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "order-db"
      }
    }

    template {
      metadata {
        labels = {
          app = "order-db"
        }
      }

      spec {
        container {
          name  = "postgres"
          image = "postgres:15"

          port {
            container_port = 5432
          }

          env {
            name  = "POSTGRES_DB"
            value = "orderdb"
          }

          env {
            name = "POSTGRES_USER"

            value_from {
              secret_key_ref {
                name = kubernetes_secret_v1.db_secret.metadata[0].name
                key  = "POSTGRES_USER"
              }
            }
          }

          env {
            name = "POSTGRES_PASSWORD"

            value_from {
              secret_key_ref {
                name = kubernetes_secret_v1.db_secret.metadata[0].name
                key  = "POSTGRES_PASSWORD"
              }
            }
          }

          readiness_probe {
            exec {
              command = ["pg_isready"]
            }

            initial_delay_seconds = 10
          }
        }
      }
    }
  }
}