resource "kubernetes_service" "sshd" {
  metadata {
    name = "sshd"
  }
  spec {
    selector = {
      app = "sshd"
    }
    port {
      port        = "2222"
      target_port = "22"
    }
    type = "LoadBalancer"
  }
}

resource "kubernetes_deployment" "sshd" {
  metadata {
    name = "sshd"
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "sshd"
      }
    }
    template {
      metadata {
        labels = {
          app = "sshd"
        }
      }
      spec {
        container {
          image = "10.0.0.57:5000/sshd:latest"
          name  = "sshd"
        }
      }
    }
  }
}
