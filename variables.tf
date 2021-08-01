variable "env" {
  type = string
}
variable "region" {
  type = string
}

### --- ###
### vpc ###
### --- ###
variable "vpc_name" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "vpc_private_subnets" {
  type = list(string)
}

variable "vpc_public_subnets" {
  type = list(string)
}
### --- ###

### --- ###
### key_pair ###
### --- ###
variable "key_pair_name" {
  type = string
}
### --- ###

### --- ###
### EC2 ###
### --- ###
variable "instance_cluster_name" {
  type = string
}

variable "instance_count" {
  type = number
}

variable "instance_ami" {
  type = string
}

variable "instance_user_data" {
  type = string
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}
### --- ###
