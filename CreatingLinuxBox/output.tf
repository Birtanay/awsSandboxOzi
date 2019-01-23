output "address" {
  value = "${aws_instance.myLinuxInstance.public_dns}"
}
output "ip" {
  value = "${aws_instance.myLinuxInstance.public_ip}"
}
