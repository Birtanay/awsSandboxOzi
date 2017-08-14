resource "aws_instance" "Tutorial_02_instance" {
  ami           = "${var.amiid}"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.Tutorial_02_asg.id}"]
  key_name = "MyKeyPair"
  tags {
	"Name" = "AWS_Tutorial_02"
  }
}

resource "aws_security_group" "Tutorial_02_asg" {
  name = "AWSTutorial02"
  ingress {
    from_port = 3389
    to_port = 3389
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
	"Name" = "AWS_Tutorial_02_asg"
  }
}

output "address" {
  value = "${aws_instance.Tutorial_02_instance.public_dns}"
}
output "ip" {
  value = "${aws_instance.Tutorial_02_instance.public_ip}"
}
