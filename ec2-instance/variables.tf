# AWS Config

variable "aws_access_key" {
  default = ""
}

variable "aws_secret_key" {
  default = ""
}

variable "aws_region" {
  default = "ap-south-1"
}

variable "ami" {
  default = "ami-02e60be79e78fef21"
}

variable "instance_type" {
  default = "t2.medium"
}

variable "vpc_security_group_ids" {
  default = ["sg-01fe62c6f88a2ffa2"]
}

variable "subnet_id" {
  default = "subnet-0c59f2b12acdcefd5"
}

variable "key_name" {
  default = "demo_mediawiki"
}
