# Database Secrets
resource "kubernetes_secret_v1" "user_db_secret" {
  metadata {
    name = "user-db-secret"
  }

  data = {
    POSTGRES_USER     = "admin"
    POSTGRES_PASSWORD = "password123"
  }

  type = "Opaque"
}

# Persistent Volume for User DB
resource "kubernetes_persistent_volume_v1" "user_db_pv" {
  metadata {
    name = "user-db-pv"
  }

  spec {
    capacity = {
      storage = "1Gi"
    }
    access_modes       = ["ReadWriteOnce"]
    storage_class_name = "manual"
    
    persistent_volume_source {
      host_path {
        path = "/mnt/data/user-db"
      }
    }
  }
}

# Persistent Volume Claim for User DB
resource "kubernetes_persistent_volume_claim_v1" "user_db_pvc" {
  metadata {
    name = "user-db-pvc"
  }

  spec {
    access_modes       = ["ReadWriteOnce"]
    storage_class_name = "manual"

    resources {
      requests = {
        storage = "1Gi"
      }
    }

    # CORRECTED REFERENCE: Added _v1 here to match the resource above
    volume_name = kubernetes_persistent_volume_v1.user_db_pv.metadata[0].name
  }
}