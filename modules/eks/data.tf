data "aws_subnets" "subnets" {
  filter {
    name   = "vpc-id"
    values = ["${var.vpc_id}"]
  }
}

data "aws_subnet" "subnet" {
  for_each = toset(data.aws_subnets.subnets.ids)
  id       = each.value
}

data "aws_iam_role" "name" {
  name = "LabRole"
}

data "aws_eks_clusters" "clusters" {}