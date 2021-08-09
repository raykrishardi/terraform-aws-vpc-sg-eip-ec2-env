env = "prod"
region = "ap-southeast-2" # Sydney

### --- ###
### vpc ###
### --- ###
vpc_name = "prod_sydney_vpc"
vpc_cidr = "10.0.0.0/16"
vpc_private_subnets = ["10.0.1.0/24"]
vpc_public_subnets = ["10.0.101.0/24"]
### --- ###

### --- ###
### key_pair ###
### --- ###
key_pair_name = "prod_sydney_key_pair"
### --- ###

### --- ###
### EC2 ###
### --- ###
instance_cluster_name = "prod_sydney_ec2"
instance_count = 1
instance_ami = "ami-0aab712d6363da7f9"
instance_type = "t2.micro"
instance_user_data = <<-EOF
                        #!/bin/bash
                        yum update -y
                        yum install -y httpd
                        systemctl enable httpd
                        systemctl start httpd
                        EOF
### --- ###