variable "aws_region" {
  description = "AWS Region"
  type        = string
}

variable "project_name" {
  description = "Project Name"
  type        = string
}

variable "RABBITMQ_DEFAULT_USER" {
  description = "Default user for RabbitMQ"
  type        = string
}

variable "RABBITMQ_DEFAULT_PASS" {
  description = "Default password for RabbitMQ"
  type        = string
}