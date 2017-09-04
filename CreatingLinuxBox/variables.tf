variable "access_key" {}
variable "secret_key" {}
variable "region" {
  default = "us-west-2"
  }

variable "AMIS" {
  type="map"
  default={
    us-west-2="ami-7105e609"
  }
}
  
data "aws_availability_zones" "available" {}