resources "aws_instance" "bayLinuxInstance" {
    ami = "${lookup(var.AMIS,var.region)}"
    instance_type = "t2.micro"
    vpc_security_group_ids = ["${aws_security_group.mysecuritygroup.id}"]
    subnet_id="${module.vpc.public_subnets[0]}"
    key_name = "${aws_key_pair.mykey.key_name}"
    iam_instance_profile = "${aws_iam_instance_profile.s3_bucket_instance_profile.name}"
    tags {
        "Name" = "AWS_LinuxBox_Bay"
    }
}