provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

resource "aws_key_pair" "provisioner" {
  key_name = "terransible_provisioner"
  public_key = "${file("keys/mykey.pub")}"
}

terraform {
  backend "s3" {
    bucket="terraform-remote-ozi"
    key="terraform/myproject"
    region="us-east-1"
  }
}