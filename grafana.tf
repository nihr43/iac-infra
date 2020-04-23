variable "GRAFANA_DB_PASS" {}

resource "postgresql_role" "grafana" {
  name     = "grafana"
  login    = true
  password = var.GRAFANA_DB_PASS
}

resource "postgresql_database" "grafana" {
  name              = "grafana"
  owner             = "grafana"
  allow_connections = true
}

resource "postgresql_grant" "grafana" {
  database    = "grafana"
  role        = "grafana"
  schema      = "public"
  object_type = "table"
  privileges  = ["SELECT","INSERT","UPDATE","DELETE"]
  depends_on  = [postgresql_role.grafana,postgresql_database.grafana]
}

resource "kubernetes_deployment" "grafana" {
  metadata {
    name = "grafana"
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "grafana"
      }
    }
    template {
      metadata {
        labels = {
          app = "grafana"
        }
      }
      spec {
        container {
          image = "grafana/grafana"
          name  = "grafana"
          env {
            name = "GF_DATABASE_URL"
	    value = "postgres://grafana:${var.GRAFANA_DB_PASS}@postgres-0:5432/grafana"
	  }
	  env {
	    name = "ssl_mode"
	    value = "disable"
	  }
        }
      }
    }
  }
}

resource "kubernetes_service" "grafana" {
  metadata {
    name = "grafana"
  }
  spec {
    selector = {
      app = "grafana"
    }
    port {
      port        = "3000"
      target_port = "3000"
    }
    type = "LoadBalancer"
  }
}
