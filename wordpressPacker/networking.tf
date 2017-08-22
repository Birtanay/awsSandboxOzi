resource "aws_vpc" "vpc_ozi" {
  enable_dns_hostnames = true
  cidr_block           = "10.0.0.0/16"
}
