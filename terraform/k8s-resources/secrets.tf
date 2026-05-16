variable "user_db_password" {
  description = "Password for the user database"
  type        = string
  sensitive   = true
}

variable "user_db_username" {
  description = "Username for the user database"
  type        = string
}

resource "kubernetes_secret_v1" "db_secret" {
  metadata {
    name = "db-secret"
  }
  data = {
    POSTGRES_USER     = var.user_db_username
    POSTGRES_PASSWORD = var.user_db_password
  }
  type = "Opaque"
}