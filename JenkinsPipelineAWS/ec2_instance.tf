resource "aws_instance" "jenkins_master" {
    ami = "${var.amiid}"
    instance_type = "${var.instance_type}"
    key_name = "ContainerECSOzi"
    security_groups = ["${aws_security_group.ssh_and_http.name}"]
    tags {
        Name = "jenkins_master"
        role = "jenkins_master"
    }
}