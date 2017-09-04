resource "aws_instance" "Tutorial_01_instance" {
  ami = "${lookup(var.AMIS,var.region)}"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.Tutorial_01_asg.id}"]
  key_name = "${aws_key_pair.mykey.key_name}"  
  tags {
	 "Name" = "AWS_Tutorial_01"
  }
}
