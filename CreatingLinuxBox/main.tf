resource "aws_instance" "Tutorial_01_instance" {
  ami           = "${var.amiid}"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.Tutorial_01_asg.id}"]
  key_name = "MyKeyPair"
  tags {
	"Name" = "AWS_Tutorial_01"
  }
}

resource "aws_security_group" "Tutorial_01_asg" {
  name = "AWSTutorial01"
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
	"Name" = "AWS_Tutorial_01_asg"
  }
}

output "address" {
  value = "${aws_instance.Tutorial_01_instance.public_dns}"
}
output "ip" {
  value = "${aws_instance.Tutorial_01_instance.public_ip}"
}
