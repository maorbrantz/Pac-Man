# outputs.tf
output "eks_cluster_endpoint" {
  description = "The endpoint of the EKS cluster"
  value       = aws_eks_cluster.cluster.endpoint
}

output "mongodb_endpoint" {
  description = "The endpoint of the MongoDB cluster"
  value       = aws_docdb_cluster.mongodb.endpoint
}
