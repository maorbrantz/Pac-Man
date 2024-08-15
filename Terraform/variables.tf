# Main Variables
variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-west-2"
}


# EKS
variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}


# EKS - Nodes Variables
variable "scaling-desired_nodes" {
  description = "Number of Instances in the Node Group"
  type        = string
  default     = "2"

}  

variable "scaling-max_nodes" {
  description = "Maximum Number of Instance in the Node Group"
  type        = string
  default     = "4"
}


# MongoDB Variables
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