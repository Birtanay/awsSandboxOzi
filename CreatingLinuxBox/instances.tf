resource "aws_instance" "Tutorial_01_instance" {
  ami = "${lookup(var.AMIS,var.region)}"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.Tutorial_01_asg.id}"]
  subnet_id="${aws_subnet.my_public_subnet.id}"
  key_name = "${aws_key_pair.mykey.key_name}"  
  iam_instance_profile = "${aws_iam_instance_profile.s3_ozi_bucket_instance_profile.name}"  
  tags {
	 "Name" = "AWS_Tutorial_01"
  }
}
