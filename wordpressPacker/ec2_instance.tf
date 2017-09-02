resource "aws_launch_configuration" "ec2_launch_configuration" {
  name                 = "ecs-launch-configuration"
  instance_type        = "${var.instance_type}"
  image_id             = "${lookup(var.AMIS,var.region)}"
  security_groups      = ["${aws_security_group.ecs_security_group_ingress.id}", "${aws_security_group.ec2_security_group_egress.id}"]
  iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"

  user_data = "${data.template_file.ec2_userdata.rendered}"
}

# We need this 'depend_on' line otherwise we may not be able to reach internet at first terraform apply command
resource "aws_autoscaling_group" "ec2_autoscaling_group" {
  depends_on           = ["aws_nat_gateway.nat_gateway_zone1", "aws_nat_gateway.nat_gateway_zone2"]
  name                 = "ecs-autoscaling-group"
  vpc_zone_identifier  = ["${aws_subnet.private_subnet_zone1.id}", "${aws_subnet.private_subnet_zone2.id}"]
  launch_configuration = "${aws_launch_configuration.ec2_launch_configuration.name}"
  min_size             = 1
  max_size             = 3
  desired_capacity     = 1
  load_balancers       = ["${aws_elb.ec2_load_balancer.name}"]
}

resource "aws_elb" "ec2_load_balancer" {
  name            = "wordpress-elb-ozi"
  security_groups = ["${aws_security_group.ecs_security_group_ingress.id}", "${aws_security_group.elb_security_group_egress.id}"]
  subnets         = ["${aws_subnet.public_subnet_zone1.id}", "${aws_subnet.public_subnet_zone2.id}"]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/wp-admin/install.php"
    interval            = 30
  }
}

data "template_file" "ec2_userdata" {
  template = "${file("userdata.sh")}"

  vars {
    ecs_cluster = "${aws_ecs_cluster.ecs_cluster_ozi.name}"
  }
}
