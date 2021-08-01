env = "dev"
region = "ap-southeast-1" # Singapore

### --- ###
### vpc ###
### --- ###
vpc_name = "dev_singapore_vpc"
vpc_cidr = "10.0.0.0/16"
vpc_private_subnets = ["10.0.1.0/24"]
vpc_public_subnets = ["10.0.101.0/24"]
### --- ###

### --- ###
### key_pair ###
### --- ###
key_pair_name = "dev_singapore_key_pair"
### --- ###

### --- ###
### EC2 ###
### --- ###
instance_cluster_name = "dev_singapore_ec2"
instance_count = 1
instance_ami = "ami-0f511ead81ccde020"
instance_type = "t2.micro"
instance_user_data = <<-EOF
                        #!/bin/bash
                        yum update -y
                        yum install -y httpd
                        systemctl enable httpd
                        systemctl start httpd
                        EOF
### --- ###