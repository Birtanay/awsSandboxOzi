resource "aws_iam_role" "s3_bucket_role" {
    name = "ROLE NAME"
    assume_role_policy = <<EOF {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Action": "sts:AssumeRole",
                "Principal": {
                    "Service": "ec2.amazonaws.com"
                },
                "Effect": "Allow",
                "Sid": ""
            }
        ] 
    }
    EOF
}

Resource "aws_iam_instance_profile" "s3_bucket_instance_profile" {
    name = "ROLE NAME"
    role = "${aws_iam_role.s3_bucket_role.name}"
}

resource "aws_iam_role_policy" "s3_bucket_role_policy" {
    name = "s3-mybucket-role-policy-bay"
    role = "${aws_iam_role.s3_bucket_role.id}"
    policy = <<EOF {
        "Version": "2012-10-07",
        "Statement": [
            {
                "Effect": "Allow",
                "Action": [
                    "s3:*"
                ],
                "Resource": [
                    "arn:aws:s3:::UNIQUE BUCKETNAME",
                    "arn:aws:s3:::UNIQUE BUCKETNAME/*"
                ]
            }
        ]
    }
    EOF
}