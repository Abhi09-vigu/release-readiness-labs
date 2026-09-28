# Infrastructure Decision Notice:
# Standalone EC2 instance is NOT recommended for production deployment due to:
# 1. Single Point of Failure (SPOF)
# 2. Lack of automated container orchestration, health monitoring, and auto-recovery
# Production environment uses Kubernetes (see deployment/kubernetes/) for multi-replica,
# load-balanced, and zero-downtime rolling deployments.

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "app_server" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  tags = {
    Name        = "LabAppServer"
    Environment = "non-production-eval"
    Status      = "deprecated-in-favor-of-kubernetes"
  }
}
