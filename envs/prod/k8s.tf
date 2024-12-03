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