# VPC Configuration
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "pacman-vpc"
  }
}

resource "aws_subnet" "subnet_a" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-west-2a"

  tags = {
    Name = "pacman-subnet-a"
  }
}

resource "aws_subnet" "subnet_b" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-west-2b"

  tags = {
    Name = "pacman-subnet-b"
  }
}

# Cluster Configuration
resource "aws_eks_cluster" "cluster" {
  name     = var.cluster_name
  role_arn  = aws_iam_role.eks.arn
  version   = "1.21"

  vpc_config {
    subnet_ids = [aws_subnet.subnet_a.id, aws_subnet.subnet_b.id]
  }
}

# IAM Role Configuration (for the cluster)
resource "aws_iam_role" "eks" {
  name = "eks-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action    = "sts:AssumeRole",
        Effect    = "Allow",
        Principal = {
          Service = "eks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role     = aws_iam_role.eks.name
}

resource "aws_eks_node_group" "node_group" {
  cluster_name    = aws_eks_cluster.cluster.name
  node_group_name = "${var.cluster_name}-node-group"
  node_role_arn   = aws_iam_role.node_role.arn
  subnet_ids      = [aws_subnet.subnet_a.id, aws_subnet.subnet_b.id]

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  instance_types = ["t3.medium"]
}

resource "aws_iam_role" "node_role" {
  name = "eks-node-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action    = "sts:AssumeRole",
        Effect    = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "node_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role     = aws_iam_role.node_role.name
}

resource "aws_iam_role_policy_attachment" "node_cni_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSCNIPolicy"
  role     = aws_iam_role.node_role.name
}

# MongoDB (Using DocumentDB)
resource "aws_docdb_cluster" "mongodb" {
  cluster_identifier = var.mongodb_cluster_identifier
  master_username    = var.mongodb_master_username
  master_password    = var.mongodb_master_password
  engine             = "docdb"

  tags = {
    Name = "pacman-mongodb-cluster"
  }
}

resource "aws_docdb_instance" "mongodb_instance" {
  count            = 2
  cluster_id       = aws_docdb_cluster.mongodb.id
  instance_class   = "db.r5.large"
  engine           = "docdb"
}
<<<<<<< HEAD

# Outputs
output "eks_cluster_endpoint" {
  description = "The endpoint of the EKS cluster"
  value       = aws_eks_cluster.cluster.endpoint
}

output "mongodb_endpoint" {
  description = "The endpoint of the MongoDB cluster"
  value       = aws_docdb_cluster.mongodb.endpoint
}
=======
>>>>>>> 4fa7cc27609a9e319c7b81c89f548a24089ae5c4
