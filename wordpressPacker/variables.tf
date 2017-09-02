variable "access_key" {}
variable "secret_key" {}
data "aws_availability_zones" "available" {}

variable "region" {
  default = "us-west-2"
}

variable "AMIS" {
  type="map"
  default={
    us-west-2="ami-022b9262"
  }
}

variable "instance_type" {
  default = "t2.micro"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet_zone1_cidr" {
  default = "10.0.0.0/24"
}

variable "public_subnet_zone2_cidr" {
  default = "10.0.1.0/24"
}

variable "private_subnet_zone1_cidr" {
  default = "10.0.10.0/24"
}

variable "private_subnet_zone2_cidr" {
  default = "10.0.11.0/24"
}
