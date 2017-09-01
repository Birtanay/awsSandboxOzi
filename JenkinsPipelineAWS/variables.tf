variable "access_key" {}
variable "secret_key" {}
data "aws_availability_zones" "available" {}

variable "region" {
  default = "eu-west-1"
}

variable "amiid" {
  default = "ami-abc579d8"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "subnet_cidr" {
  default = "10.0.0.0/24"
}