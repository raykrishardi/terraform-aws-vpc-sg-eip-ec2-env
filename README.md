# terraform-aws-vpc-sg-eip-ec2-env
Terraform script to create VPC, Security Group, Elastic IP, and EC2 in various environments (prod and dev) on AWS

## Assumptions:
- `dev` environment
  - `region` -> `ap-southeast-1` (Singapore)

## TODO:
1. Create `prod.tfvars` file under `environments/` dir
2. Separate `dev` and `prod` env using `terraform workspace` 

## Getting Started

```
aws configure
git clone https://github.com/raykrishardi/terraform-aws-vpc-sg-eip-ec2-env.git
cd terraform-aws-vpc-sg-eip-ec2-env
terraform init
terraform apply -var-file environments/dev.tfvars
```
