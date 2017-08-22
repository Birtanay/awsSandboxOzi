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
