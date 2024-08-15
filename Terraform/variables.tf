# variables.tf
variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-west-2"
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "mongodb_cluster_identifier" {
  description = "Identifier for the MongoDB cluster"
  type        = string
}

variable "mongodb_master_username" {
  description = "Master username for MongoDB"
  type        = string
}

variable "mongodb_master_password" {
  description = "Master password for MongoDB"
  type        = string
  sensitive   = true
}
