output "url_api" {
  value = length(kubernetes_service.LoadBalancer) > 0 ? kubernetes_service.LoadBalancer[0].status[0].load_balancer[0].ingress[0].hostname : data.kubernetes_service.existing_service.status[0].load_balancer[0].ingress[0].hostname
  description = "The URL of the API"
}
