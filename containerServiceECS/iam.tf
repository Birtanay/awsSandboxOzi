resource "aws_iam_role" "ecs_instance_role" {
  name               = "ecs-instance-role"
  assume_role_policy = "${file("ec2-role.json")}"
}

resource "aws_iam_role_policy_attachment" "ecs_instance_role_policy" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
  role       = "${aws_iam_role.ecs_instance_role.id}"
}

resource "aws_iam_instance_profile" "ecs" {
  name = "ecs-instance-profile"
  path = "/"
  role = "${aws_iam_role.ecs_instance_role.name}"
}

resource "aws_iam_role" "ecs_elb" {
  name               = "ecs-elb"
  assume_role_policy = "${file("ecs-role.json")}"
}

resource "aws_iam_role_policy_attachment" "ecs_elb" {
  role       = "${aws_iam_role.ecs_elb.id}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
}
