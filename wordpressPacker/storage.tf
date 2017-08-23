resource "aws_efs_file_system" "efs_file_system_ozi" {
  creation_token = "wordpress-assets"
}

resource "aws_efs_mount_target" "efs_private_zone1" {
  file_system_id  = "${aws_efs_file_system.efs_file_system_ozi.id}"
  security_groups = ["${aws_security_group.efs_security_group_ingress.id}"]
  subnet_id       = "${aws_subnet.private_subnet_zone1.id}"
}

resource "aws_efs_mount_target" "efs_private_zone2" {
  file_system_id  = "${aws_efs_file_system.efs_file_system_ozi.id}"
  security_groups = ["${aws_security_group.efs_security_group_ingress.id}"]
  subnet_id       = "${aws_subnet.private_subnet_zone2.id}"
}
