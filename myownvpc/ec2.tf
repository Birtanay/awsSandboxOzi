resource "aws_instance" "ec2_webinstance" {
  ami = "${var.ami_id}"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.MyWebDMZ.id}"]
  subnet_id="${aws_subnet.public_subnet.id}"
  key_name = "${aws_key_pair.mykey.key_name}"  
  user_data = "${data.template_file.userdata_web.rendered}"
  tags {
	 "Name" = "mywebinstance"
  }
}

resource "aws_instance" "ec2_mysqlinstance" {
  ami = "${var.ami_id}"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.MySQLServerSG.id}"]
  subnet_id="${aws_subnet.private_subnet.id}"
  key_name = "${aws_key_pair.mykey.key_name}"  
  user_data = "${data.template_file.userdata_mysql.rendered}"
  tags {
	 "Name" = "mysqlinstance"
  }
}

data "template_file" "userdata_web" {
  template = "${file("userdata_web.sh")}"
}

data "template_file" "userdata_mysql" {
  template = "${file("userdata_mysql.sh")}"
}