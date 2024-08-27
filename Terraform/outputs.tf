# Output the EKS Cluster endpoint
output "eks_cluster_endpoint" {
  description = "The endpoint of the EKS cluster"
  value       = aws_eks_cluster.Cluster.endpoint
}

# Output the ECR repository URI
# output "ecr_repository_uri" {
#  value = aws_ecr_repository.PacMan_Repository.repository_url
#  description = "The URI of the ECR repository"
#}