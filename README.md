# terraform-aws-vpc-sg-eip-ec2-env
Terraform script to create VPC, Security Group, Elastic IP, and EC2 in various environments (prod and dev) on AWS

## Assumptions:
- `dev` environment/workspace
  - `region` -> `ap-southeast-1` (Singapore)
- `prod` environment/workspace
  - `region` -> `ap-southeast-2` (Sydney)

## Getting Started

```
aws configure
git clone https://github.com/raykrishardi/terraform-aws-vpc-sg-eip-ec2-env.git
cd terraform-aws-vpc-sg-eip-ec2-env
terraform init
```

### Deploy on `dev` workspace/environment

```
terraform workspace new dev
terraform apply -var-file environments/dev.tfvars
```

### Deploy on `prod` workspace/environment

```
terraform workspace new prod
terraform apply -var-file environments/prod.tfvars
```

## Clean Up

### Destroy `dev` workspace/environment resources
```
terraform workspace select dev
terraform destroy -var-file environments/dev.tfvars
```

### Destroy `prod` workspace/environment resources
```
terraform workspace select prod
terraform destroy -var-file environments/prod.tfvars
```
