output "ip" {
  value = "${aws_instance.ubuntu_instance.public_ip}"
}