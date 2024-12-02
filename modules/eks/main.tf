data "aws_subnets" "subnets"{
    filter {
        name = "vpc-id"
        values = ["${var.vpc_id}"]
    }
}

data "aws_subnet" "subnet" {
  for_each = toset(data.aws_subnets.subnets.ids)
  id       = each.value
}

resource "aws_eks_cluster" "cluster-created" {
  name     = "${var.cluster_name}-cluster"
  role_arn = data.aws_iam_role.name.arn
  vpc_config {
    endpoint_private_access = true
    endpoint_public_access  = true
    public_access_cidrs     = ["0.0.0.0/0"]
    security_group_ids      = [var.security_group_id]
    subnet_ids              = [for subnet in data.aws_subnet.subnet : subnet.id if subnet.availability_zone != "${var.default_region}e"]

  }
  tags = {
    Name = "${var.cluster_name}-cluster"
  }
  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_eks_node_group" "node_cluster_group" {
  cluster_name    = "${var.cluster_name}-cluster"
  node_group_name = "${var.cluster_name}-node-group"
  node_role_arn   = data.aws_iam_role.name.arn
  subnet_ids      = [for subnet in data.aws_subnet.subnet : subnet.id if subnet.availability_zone != "${var.default_region}e"]
  scaling_config {
    desired_size = 3
    max_size     = 5
    min_size     = 1
  }
  lifecycle {
    prevent_destroy = false
  }
  instance_types = ["t2.micro"]
  disk_size      = 50
  ami_type = "AL2_x86_64"
  depends_on = [aws_eks_cluster.cluster-created]
}

data "aws_iam_role" "name" {
  name = "LabRole"
}