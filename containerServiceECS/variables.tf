variable "access_key" {}
variable "secret_key" {}

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
