terraform {
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.14.0"
    }
  }
}

provider "kubectl" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  load_config_file       = false
}

# VPC module to create VPC, subnets, etc.
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "jenkins-vpc"
  cidr = var.vpc_cidr

  azs             = data.aws_availability_zones.azs.names
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_dns_hostnames = true
  enable_nat_gateway   = true
  single_nat_gateway   = true

  tags = {
    "kubernetes.io/cluster/my-eks-cluster" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/my-eks-cluster" = "shared"
    "kubernetes.io/role/elb"               = "true"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/my-eks-cluster" = "shared"
    "kubernetes.io/role/internal-elb"      = "true"
  }
}

# EKS module to create the EKS cluster
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.31"

  cluster_name    = "my-eks-cluster"
  cluster_version = "1.29" # Change to your desired version
  cluster_endpoint_public_access = true

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  eks_managed_node_groups = {
    node = {
      min_size      = 1
      max_size      = 3
      desired_size  = 2
      instance_type = ["t2.small"]

      tags = {
        Environment = "dev"
        Terraform   = "true"
      }
    }
  }

  cluster_tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}

# AWS authentication via IAM user for Kubernetes access
resource "kubernetes_config_map" "aws_auth" {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    mapUsers = jsonencode([
      {
        userarn  = "arn:aws:iam::767397667940:user/Mahmoodi"
        username = "Mahmoodi"
        groups   = ["system:masters"]
      }
    ])
  }

  depends_on = [module.eks]
}

# Optional: Create IAM role for EKS operations (useful for your admin tasks)
resource "aws_iam_role" "Terraform_eks_role" {
  name = "mahmoodi-eks-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# Create IAM policy to manage Kubernetes and EKS resources
resource "aws_iam_policy" "eks_admin_policy" {
  name        = "eks-admin-policy"
  description = "Policy for Terraform to manage Kubernetes and run Nginx"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "eks:DescribeCluster",
        "eks:ListClusters",
        "eks:DescribeNodegroup",
        "eks:ListNodegroups",
        "eks:AccessKubernetesApi",
        "eks:ListUpdates",
        "eks:UpdateClusterConfig",
        "eks:UpdateNodegroupConfig"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "elasticloadbalancing:DescribeLoadBalancers",
        "elasticloadbalancing:DescribeTargetGroups",
        "ec2:DescribeInstances"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

# Attach the IAM policy to the role
resource "aws_iam_role_policy_attachment" "eks_admin_attach" {
  policy_arn = aws_iam_policy.eks_admin_policy.arn
  role       = aws_iam_role.Terraform_eks_role.name
}
