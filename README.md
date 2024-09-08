# EKS CI/CD Pipeline - Final Project [Pac-Man Game]

## Introduction

This project implements the classic **Pac-Man** game as a microservice architecture using **Amazon Elastic Kubernetes Service (EKS)** and **AWS Native Services**. The goal was to create an automated CI/CD pipeline that manages the deployment of the Pac-Man game and its database, with a focus on infrastructure-as-code, scalability, and monitoring.

## Application Components

- **Pac-Man App**: A Node.js-based front-end for the Pac-Man game.
- **Database**: MongoDB for game data persistence, deployed using a Kubernetes StatefulSet with persistent storage.

## Architecture Overview

The architecture is designed to use **Amazon Web Services (AWS)** for a highly available and scalable infrastructure. It includes the following components:

1. **EKS Cluster**: Provisioned using **Terraform**, consisting of two `t3.medium` worker nodes to host the application and database.
2. **Load Balancer**: Automatically created by Kubernetes to expose the Pac-Man game to the internet.
3. **CI/CD Pipeline**: Built with AWS services, including **CodePipeline**, **CodeBuild**, and **ECR**, for continuous integration and deployment.
4. **Persistent Storage**: **EBS (Elastic Block Store)** volumes for MongoDB data, ensuring durability and state persistence.
5. **Monitoring**: Optional integration of **Prometheus** and **Grafana** for real-time monitoring of the EKS cluster, tracking CPU, memory, and storage utilization.

## Project Features

### 1. **Infrastructure as Code (IaC) with Terraform**
   - All AWS resources were provisioned using **Terraform**, enabling repeatable and scalable infrastructure deployment.
   - The infrastructure includes:
     - **VPC**, subnets, security groups, and Internet Gateway.
     - **Amazon EKS cluster** with two `t3.medium` worker nodes.

### 2. **Microservices Deployment on EKS**
   - The **Pac-Man application** is containerized and deployed on the EKS cluster using Kubernetes.
   - The **MongoDB database** is deployed as a StatefulSet, with persistent volumes provided by **Amazon EBS**.

### 3. **CI/CD Pipeline with AWS CodePipeline**
   - A fully automated **CI/CD pipeline** was set up using:
     - **AWS CodeBuild**: Builds the Docker images for the application.
     - **Amazon ECR**: Stores the Docker images.
     - **AWS CodePipeline**: Orchestrates the end-to-end process from source code changes to production deployment on EKS.

### 4. **Load Balancing**
   - The **Pac-Man application** is exposed via a Kubernetes **LoadBalancer** service, enabling external access to the game.

### 5. **Stateful Database Deployment**
   - The MongoDB database is deployed with a **StatefulSet**, ensuring data persistence across pod restarts. Storage is handled by **Persistent Volumes** backed by AWS **EBS**.

### 6. **Monitoring with Grafana and Prometheus** (Optional)
   - **Prometheus** was used to collect Kubernetes metrics.
   - **Grafana** provided a dashboard for real-time monitoring of cluster utilization, including CPU, memory, and storage usage.

## Project Repository

The complete project can be found in the following structure:

```bash
├── Source/
├── Terraform/
├── Kubernetes-Manifests/
├── CI-CD-Pipeline/
├── Screenshots/
├── Diagrams/
```

- Source: Contains the source code for the Pac-Man application.
- Terraform: Contains all Terraform configuration files to provision AWS resources.
- Kubernetes-Manifests: Kubernetes manifests for deploying the Pac-Man app and MongoDB.
- CI-CD-Pipeline: Contains the configuration files for AWS CodePipeline and CodeBuild.
- Screenshots: Contains screenshots of the running application, CI/CD pipeline, and monitoring dashboards.
- Diagrams: Architecture and CI/CD pipeline diagrams.

## Screenshots

**Pac-Man Application:**
- [Complete Later]

**CI/CD Pipeline:**
- [Complete Later]

**Grafana Monitoring Dashboard:**
- [Complete Later]

## Conclusion

This project successfully implements a Pac-Man game using microservices architecture on Amazon EKS, with automated CI/CD pipeline management and persistent database storage. The project showcases modern DevOps practices, including Infrastructure as Code (IaC) with Terraform, Kubernetes for container orchestration, and AWS services for scalability, high availability, and monitoring.
