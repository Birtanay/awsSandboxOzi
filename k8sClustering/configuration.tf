provider "aws" {
  aws_access_key = "${var.access_key}"
  aws_secret_key = "${var.secret_key}"
  aws_region     = "${var.region}"
}