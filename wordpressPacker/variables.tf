variable "access_key" {}
variable "secret_key" {}

variable "region" {
  default = "us-east-1"
}

variable "amiid" {
  default = "ami-022b9262"
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
