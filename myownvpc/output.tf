output "public_ip_webinstance" {
  value = "${aws_instance.ec2_webinstance.public_ip}"
}

output "private_ip_mysqlinstance" {
  value = "${aws_instance.ec2_mysqlinstance.private_ip}"
}