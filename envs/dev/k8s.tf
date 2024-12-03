resource "kubernetes_deployment" "rabbitmq" {
  count = length(kubernetes_config_map.rabbit-configmap) > 0 ? 1 : 0

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
              name = kubernetes_config_map.rabbit-configmap[0].metadata[0].name
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
  count = length(data.kubernetes_service.existing_service) == 0 ? 1 : 0

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
  count = length(data.kubernetes_config_map.existing_configmap) == 0 ? 1 : 0

  metadata {
    name = "${var.project_name}-configmap"
  }

  data = {
    RABBITMQ_DEFAULT_USER : var.RABBITMQ_DEFAULT_USER
    RABBITMQ_DEFAULT_PASS : var.RABBITMQ_DEFAULT_PASS
  }
}

data "kubernetes_service" "existing_service" {
  metadata {
    name = "load-balancer-${var.project_name}"
  }
}

data "kubernetes_config_map" "existing_configmap" {
  metadata {
    name = "${var.project_name}-configmap"
  }
}
