resource "aws_iam_role" "my_ec2_role" {
    name = "ozi-ec2-role"
    assume_role_policy = <<EOF
{
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

resource "aws_iam_instance_profile" "my_ec2_instance_profile" {
    name = "ozi-ec2-instance-profile"
    role = "${aws_iam_role.my_ec2_role.name}"
}



resource "aws_iam_role" "my_elasticbeanstalk_service_role" {
    name = "ozi-elasticbeanstalk-service-role"
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "elasticbeanstalk.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}


resource "aws_iam_policy_attachment" "policy_attach_AWSElasticBeanstalkWebTier" {
    name = "app-attach1"
    roles = ["${aws_iam_role.my_ec2_role.name}"]
    policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWebTier"
}
resource "aws_iam_policy_attachment" "policy_attach_AWSElasticBeanstalkMulticontainerDocker" {
    name = "app-attach2"
    roles = ["${aws_iam_role.my_ec2_role.name}"]
    policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkMulticontainerDocker"
}
resource "aws_iam_policy_attachment" "policy_attach_AWSElasticBeanstalkWorkerTier" {
    name = "app-attach3"
    roles = ["${aws_iam_role.my_ec2_role.name}"]
    policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWorkerTier"
}
resource "aws_iam_policy_attachment" "policy_attach_AWSElasticBeanstalkEnhancedHealth" {
    name = "app-attach4"
    roles = ["${aws_iam_role.my_elasticbeanstalk_service_role.name}"]
    policy_arn = "arn:aws:iam::aws:policy/service-role/AWSElasticBeanstalkEnhancedHealth"
}
