variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "default_region" {
  description = "The default region to deploy the EKS cluster"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID to deploy the EKS cluster"
  type        = string
}

variable "security_group_id" {
  description = "The security group IDs to associate with the EKS cluster"
  type        = string
}