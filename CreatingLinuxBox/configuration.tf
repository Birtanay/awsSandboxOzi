provider "aws" {
  access_key = "${var.AWS_ACCESS_KEY}"
  secret_key = "${var.AWS_SECRET_KEY}"
  region     = "${var.region}"
}
resource "aws_key_pair" "mykey" {
  key_name = "mykey"
  public_key = "${file("mykey.pub")}"
}
