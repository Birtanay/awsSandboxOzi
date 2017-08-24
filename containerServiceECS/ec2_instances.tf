resource "aws_elb" "main_load_balancer" {
  name               = "ecs-load-balancer"
  security_groups    = ["${aws_security_group.ssh_http_from_to_anywhere.id}"]
  availability_zones = ["${data.aws_availability_zones.all.names}"]

  # subnets         = ["${aws_subnet.container_subnet.id}"]

  listener {
    lb_protocol       = "http"
    lb_port           = 80
    instance_protocol = "http"
    instance_port     = 8000
  }
  health_check {
    target              = "HTTP:8000/"
    timeout             = 5
    interval            = 30
    unhealthy_threshold = 2
    healthy_threshold   = 10
  }
  tags {
    Name = "ecs-load-balancer"
  }
}

resource "aws_launch_configuration" "ecs_launch_configuration" {
  name                 = "ecs-launch-configuration"
  image_id             = "${var.amiid}"
  instance_type        = "${var.instance_type}"
  security_groups      = ["${aws_security_group.ssh_http_from_to_anywhere.id}"]
  iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"
  key_name             = "ContainerECSOzi"

  #  associate_public_ip_address = true
  user_data = "#!/bin/bash\necho ECS_CLUSTER='${aws_ecs_cluster.main_cluster.name}' > /etc/ecs/ecs.config"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "ecs_autoscaling_group" {
  availability_zones   = ["${data.aws_availability_zones.all.names}"]
  name                 = "ecs-autoscaling-group"
  min_size             = 3
  max_size             = 5
  desired_capacity     = 4
  health_check_type    = "ELB"
  load_balancers       = ["${aws_elb.main_load_balancer.name}"]
  launch_configuration = "${aws_launch_configuration.ecs_launch_configuration.id}"

  #  vpc_zone_identifier  = ["${aws_subnet.container_subnet.id}"]
}
