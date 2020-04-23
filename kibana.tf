resource "kubernetes_service" "kibana" {
  metadata {
    name = "kibana"
  }
  spec {
    selector = {
      app = "kibana"
    }
    port {
      port        = "5601"
      target_port = "5601"
    }
    type = "LoadBalancer"
  }
}

resource "kubernetes_deployment" "kibana" {
  metadata {
    name = "kibana"
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "kibana"
      }
    }
    template {
      metadata {
        labels = {
          app = "kibana"
        }
      }
      spec {
        container {
          image = "docker.elastic.co/kibana/kibana-oss:6.4.3"
          name  = "kibana"
	  env {
            name = "ELASTICSEARCH_URL"
	    value = "http://elasticsearch.localnet:9200"
	  }
        }
      }
    }
  }
}
