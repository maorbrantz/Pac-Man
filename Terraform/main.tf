#-----------------------------------
# Pac-Man Project
# Created by Maor Brantz
#-----------------------------------



#--------------- VPC ---------------

# Create VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "pacman-vpc"
  }
}

# Create Subnet A
resource "aws_subnet" "subnet_a" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-west-2a"

  tags = {
    Name = "pacman-subnet-a"
  }
}

# Create Subnet B
resource "aws_subnet" "subnet_b" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-west-2b"

  tags = {
    Name = "pacman-subnet-b"
  }
}

#---------------EKS---------------

# IAM Role for EKS
resource "aws_iam_role" "eks_role" {
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

# Add Policy to IAM Role for EKS
resource "aws_iam_role_policy_attachment" "eks_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role     = aws_iam_role.eks_role.name
}

# Cluster Configuration
resource "aws_eks_cluster" "cluster" {
  name     = var.cluster_name
  role_arn  = aws_iam_role.eks_role.arn
  version   = "1.21"

  vpc_config {
    subnet_ids = [aws_subnet.subnet_a.id, aws_subnet.subnet_b.id]
  }
}

# IAM Role for Nodes
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

# Add Policy to IAM Role for Nodes
resource "aws_iam_role_policy_attachment" "node_role-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role     = aws_iam_role.node_role.name
}

resource "aws_iam_role_policy_attachment" "node_role-AmazonEKSCNIPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSCNIPolicy"
  role     = aws_iam_role.node_role.name
}

resource "aws_iam_role_policy_attachment" "node_role-AmazonEC2ContainerRegistryReadOnlyy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role     = aws_iam_role.node_role.name
}

resource "aws_iam_role_policy_attachment" "node_role-AmazonSSMManagedInstanceCore" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role     = aws_iam_role.node_role.name
}

# Create Node Group
resource "aws_eks_node_group" "worker_nodes_group" {
  cluster_name    = aws_eks_cluster.cluster.name
  node_group_name = "${var.cluster_name}-worker-nodes-group"
  node_role_arn   = aws_iam_role.node_role.arn
  subnet_ids      = [aws_subnet.subnet_a.id, aws_subnet.subnet_b.id]

  scaling_config {
    desired_size = var.scaling-desired_nodes
    max_size     = var.scaling-max_nodes
    min_size     = var.scaling-desired_nodes
  }

  instance_types = ["t3.medium"]
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