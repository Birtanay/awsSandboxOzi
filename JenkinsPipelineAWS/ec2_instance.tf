resource "aws_instance" "jenkins_master" {
    ami = "${var.amiid}"
    instance_type = "${var.instance_type}"
    key_name = "${aws_key_pair.provisioner.key_name}"
    vpc_security_group_ids = ["${aws_security_group.ssh_http_from_to_anywhere.id}"]
    subnet_id="${aws_subnet.jenkins_subnet.id}"
    tags {
        Name = "jenkins_master"
        role = "jenkins_master"
    }
}