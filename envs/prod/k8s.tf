resource "kubernetes_deployment" "rabbitmq" {
  metadata {
    name = var.project_name
    labels = {
      name = "${var.project_name}-deployment"
    }
  }
  spec {
    replicas = 3
    selector {
      match_labels = {
        app = "${var.project_name}-pod"
      }
    }
    template {
      metadata {
        name = "${var.project_name}-pod"
        labels = {
          app = "${var.project_name}-pod"
        }
      }
      spec {
        container {
          image = "rabbitmq:3.10-management"
          name  = "${var.project_name}-container"
          env_from {
            config_map_ref {
              name = kubernetes_config_map.rabbit-configmap.metadata[0].name
            }
          }
          resources {
            limits = {
              cpu = "500m"
            }
            requests = {
              cpu = "10m"
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "LoadBalancer" {
  metadata {
    name = "load-balancer-${var.project_name}"
  }
  spec {
    selector = {
      app = "${var.project_name}-pod"
    }
    port {
      name        = "amqp"
      port        = 5672
      target_port = 5672
    }
    port {
      name        = "management"
      port        = 80
      target_port = 15672
    }
    type = "LoadBalancer"
  }
}

resource "kubernetes_config_map" "rabbit-configmap" {
  metadata {
    name = "${var.project_name}-configmap"
  }

  data = {
    RABBITMQ_DEFAULT_USER : var.RABBITMQ_DEFAULT_USER
    RABBITMQ_DEFAULT_PASS : var.RABBITMQ_DEFAULT_PASS
  }
}