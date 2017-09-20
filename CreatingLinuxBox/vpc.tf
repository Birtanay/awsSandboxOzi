module "vpc" {
  source = "github.com/terraform-aws-modules/terraform-aws-vpc"

  name = "my-vpc"
  cidr = "${var.vpc_cidr}"
  enable_dns_hostnames = true

  azs             = ["${data.aws_availability_zones.available.names[0]}"]
  public_subnets  = ["${var.subnet_cidr}"]

  #enable_nat_gateway = true
  map_public_ip_on_launch = true

  public_subnet_tags = {
      Name = "my-subnet"
  }
  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}