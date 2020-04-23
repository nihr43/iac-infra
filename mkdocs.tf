resource "kubernetes_service" "mkdocs" {
  metadata {
    name = "mkdocs"
  }
  spec {
    selector = {
      app = "mkdocs"
    }
    port {
      port        = "8000"
      target_port = "8000"
    }
    type = "LoadBalancer"
  }
}

resource "kubernetes_deployment" "mkdocs" {
  metadata {
    name = "mkdocs"
  }
  spec {
    replicas = 2
    selector {
      match_labels = {
        app = "mkdocs"
      }
    }
    template {
      metadata {
        labels = {
          app = "mkdocs"
        }
      }
      spec {
        container {
          image = "docker-registry.localnet:5000/mkdocs:latest"
          name  = "mkdocs"
        }
      }
    }
  }
}
