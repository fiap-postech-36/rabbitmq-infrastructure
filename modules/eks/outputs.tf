output "endpoint" {
  value = length(data.aws_eks_cluster.existing_cluster) > 0 ? data.aws_eks_cluster.existing_cluster.endpoint : aws_eks_cluster.cluster-created[0].endpoint
}

output "cluster_name" {
  value = length(data.aws_eks_cluster.existing_cluster) > 0 ? data.aws_eks_cluster.existing_cluster.name : aws_eks_cluster.cluster-created[0].name
}

output "cluster_ca_certificate" {
  value = length(data.aws_eks_cluster.existing_cluster) > 0 ? data.aws_eks_cluster.existing_cluster.certificate_authority[0].data : aws_eks_cluster.cluster-created[0].certificate_authority[0].data
}

output "subnet_data" {
  value = data.aws_subnets.subnets
}
