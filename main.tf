provider "aws" {
  region = var.region
}

# VPC
# Reference: 
# 1. https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest
# 2. https://github.com/terraform-aws-modules/terraform-aws-vpc/blob/v3.2.0/examples/simple-vpc/main.tf
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.2.0"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs             = ["${var.region}a", "${var.region}b"]
  private_subnets = var.vpc_private_subnets
  public_subnets  = var.vpc_public_subnets

  # Use single NAT gateway per VPC
  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false

  tags = {
    Terraform   = "true"
    Environment = var.env
  }
}

# Key pair
# Reference:
# 1. https://registry.terraform.io/modules/terraform-aws-modules/key-pair/aws/latest
resource "tls_private_key" "this" {
  algorithm = "RSA"
}

resource "local_file" "this" {
  depends_on = [
    tls_private_key.this
  ]
  filename        = "./${var.key_pair_name}.pem"
  content         = tls_private_key.this.private_key_pem
  file_permission = "0400"
}

module "key_pair" {
  depends_on = [
    tls_private_key.this
  ]
  source = "terraform-aws-modules/key-pair/aws"

  key_name   = var.key_pair_name
  public_key = tls_private_key.this.public_key_openssh
}

# EC2
# Reference: 
# 1. https://registry.terraform.io/modules/terraform-aws-modules/ec2-instance/aws/latest
module "ec2_cluster" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "2.19.0"

  depends_on = [
    module.vpc,
    module.key_pair
  ]

  name           = var.instance_cluster_name
  instance_count = var.instance_count

  ami                    = var.instance_ami
  instance_type          = var.instance_type
  key_name               = module.key_pair.key_pair_key_name
  vpc_security_group_ids = ["${module.vpc.default_security_group_id}"]
  subnet_id              = module.vpc.public_subnets[0]
  user_data              = var.instance_user_data

  tags = {
    Terraform   = "true"
    Environment = var.env
  }
}

# EIP
# Reference:
# 1. https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip
resource "aws_eip" "eip_ec2" {
  depends_on = [
    module.ec2_cluster
  ]
  instance = module.ec2_cluster.id[0]
  vpc      = true
}