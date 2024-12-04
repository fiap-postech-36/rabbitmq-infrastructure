provider "aws" {
  region = var.aws_region
}

provider "kubernetes" {
  host                   = module.eks.endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_ca_certificate)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args        = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
  }
}

module "vpc" {
  source = "github.com/fiap-postech-36/vpc-infrastructure?ref=v1.0.0"

  name                 = var.project_name
  vpc_cidr             = "10.0.0.0/16"
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  private_subnet_cidrs = []
}

module "eks" {
  source = "github.com/fiap-postech-36/eks-infrastructure?ref=v1.1.1"

  cluster_name      = var.project_name
  vpc_id            = module.vpc.vpc_id
  default_region    = var.aws_region
  security_group_id = aws_security_group.sg_cluster.id

  depends_on = [module.vpc]
}