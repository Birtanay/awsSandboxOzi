variable "access_key" {}
variable "secret_key" {}
variable "account_id" {}

data "aws_availability_zones" "available" {}

variable "ami_id" {
  default = "ami-e689729e"
}
variable "region" {
  default = "us-west-2"
}

variable "cidrs" {
  type = "map"
  default = {
    all = "0.0.0.0/0"
    vpc = "10.0.0.0/16"
    public_subnet = "10.0.1.0/24"
    private_subnet = "10.0.2.0/24"
  }
}