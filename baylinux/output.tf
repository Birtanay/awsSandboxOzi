output "address" {
    value = "${aws_instance.bayLinuxinstance.public_dns}"
}
output "ip" {
    value = "${aws_instance.bayLinuxinstance.public_ip}"
}