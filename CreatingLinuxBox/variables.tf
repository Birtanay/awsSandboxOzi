variable "aws_region" {
  default = "us-west-2"
  }

variable "AMIS" {
  type="map"
  default={
    us-west-2="ami-7105e609"
  }
}
  
data "aws_availability_zones" "available" {}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "subnet_cidr" {
  default = "10.0.0.0/24"
}
