output "endpoint" {
  value = aws_eks_cluster.cluster-created.endpoint
}

output "cluster_name" {
  value = aws_eks_cluster.cluster-created.name
}

output "cluster_ca_certificate" {
  value = aws_eks_cluster.cluster-created.certificate_authority[0].data
}