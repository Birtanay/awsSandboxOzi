variable "access_key" {}
variable "secret_key" {}

# I am not sure region and ami is fine with this project
variable "region" {
  default = "us-east-1"
}

variable "amiid" {
  default = "ami-d61027ad"
}

variable "instance_type" {
  default = "t2.micro"
}

data "aws_availability_zones" "all" {}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "subnet_cidr" {
  default = "10.0.1.0/24"
}
