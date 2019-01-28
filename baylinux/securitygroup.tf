resource "aws_security_group" "mysecuritygroup" {
    name = "LinuxBoxSecGroup"
    vpc_id = "${module.vpc.vpc_id}"
    ingress {
        from port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    engress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags {
        "Name" = "SG for Linux Instance"
    }
}