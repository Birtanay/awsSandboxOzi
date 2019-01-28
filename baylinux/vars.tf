variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "region" {
    default = "eu-west-2"
}

variable "AMIS" {
    type = "map"
    default = {
        eu-west-2 = "ami-01419b804382064e4"
    }
}
data "aws_availability_zones" "available" {}

variable "vc_cidr" {
    default = "10.0.0.0/16"
}

variable "subnet_cidr" {
    default = "10.0.0.0/24"
}