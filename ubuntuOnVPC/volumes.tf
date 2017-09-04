resource "aws_ebs_volume" "example" {
    availability_zone = "${data.aws_availability_zones.available.names[0]}"
    size = 20
    type="gp2"
    tags {
        Name = "HelloWorld"
    }
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "${var.INSTANCE_DEVICE_NAME}"
  volume_id   = "${aws_ebs_volume.example.id}"
  instance_id = "${aws_instance.ubuntu_instance.id}"
}