resource "aws_instance" "ubuntu_instance" {
  ami = "${lookup(var.AMIS,var.region)}"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.ubuntu_ASG.id}"]
  subnet_id="${aws_subnet.my_public_subnet.id}"
  key_name = "${aws_key_pair.mykey.key_name}"  

  tags {
	 "Name" = "my-ubuntu-instance"
  }

  provisioner "file" {
    content="${data.template_file.volumes_script.rendered}"
    destination = "/tmp/volumes.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/volumes.sh",
      "sudo /tmp/volumes.sh",
    ]
  }  
  connection {
    user     = "ubuntu"
    private_key = "${file("keys/mykey")}"
  }
}
