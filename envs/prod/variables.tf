variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project Name"
  type        = string
  default = "rabbitmq-infra"
}

variable "RABBITMQ_DEFAULT_USER" {
  description = "Default user for RabbitMQ"
  type        = string
  default = "fiap"
}

variable "RABBITMQ_DEFAULT_PASS" {
  description = "Default password for RabbitMQ"
  type        = string
  default = "GpP36_Fiap@2024!"
}