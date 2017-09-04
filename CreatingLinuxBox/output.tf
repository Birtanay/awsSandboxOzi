output "address" {
  value = "${aws_instance.Tutorial_01_instance.public_dns}"
}
output "ip" {
  value = "${aws_instance.Tutorial_01_instance.public_ip}"
}