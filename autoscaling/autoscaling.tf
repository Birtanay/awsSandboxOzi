resource "aws_launch_configuration" "ozi_launch_configuration" {
  name_prefix          = "my-launch-configuration"
  image_id             = "${lookup(var.AMIS, var.region)}"
  instance_type        = "t2.micro"
  key_name             = "${aws_key_pair.mykey.key_name}"
  security_groups      = ["${aws_security_group.Tutorial_01_asg.id}"]
  user_data            = "#!/bin/bash\napt-get update\napt-get -y install nginx\nMYIP=`ifconfig | grep 'addr:10' | awk '{ print $2 }' | cut -d ':' -f2`\necho 'this is: '$MYIP > /var/www/html/index.html"
  lifecycle              { create_before_destroy = true }  
}

resource "aws_autoscaling_group" "ozi_asg" {
  name                 = "my-autoscaling"
  vpc_zone_identifier  = ["${aws_subnet.my_public_subnet.id}"]
  launch_configuration = "${aws_launch_configuration.ozi_launch_configuration.name}"
  min_size             = 2
  max_size             = 3
  health_check_grace_period = 300
  load_balancers = ["${aws_elb.my_elb.name}"]
  health_check_type = "ELB"
  force_delete = true

  tag {
      key = "Name"
      value = "my-autoscaling-instance"
      propagate_at_launch = true
  }
}

resource "aws_autoscaling_policy" "my_cpu_policy" {
  name                   = "my-cpu-policy"
  autoscaling_group_name = "${aws_autoscaling_group.ozi_asg.name}"
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "1"
  cooldown               = "300"
  policy_type            = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "example-cpu-alarm" {
  alarm_name          = "example-cpu-alarm"
  alarm_description   = "example-cpu-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "30"

  dimensions = {
    "AutoScalingGroupName" = "${aws_autoscaling_group.ozi_asg.name}"
  }

  actions_enabled = true
  alarm_actions   = ["${aws_autoscaling_policy.my_cpu_policy.arn}"]
}

resource "aws_autoscaling_policy" "my_cpu_policy_scaledown" {
  name                   = "example-cpu-policy-scaledown"
  autoscaling_group_name = "${aws_autoscaling_group.ozi_asg.name}"
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "-1"
  cooldown               = "300"
  policy_type            = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "example-cpu-alarm-scaledown" {
  alarm_name          = "example-cpu-alarm-scaledown"
  alarm_description   = "example-cpu-alarm-scaledown"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "5"

  dimensions = {
    "AutoScalingGroupName" = "${aws_autoscaling_group.ozi_asg.name}"
  }

  actions_enabled = true
  alarm_actions   = ["${aws_autoscaling_policy.my_cpu_policy_scaledown.arn}"]
}

resource "aws_elb" "my_elb" {
  name = "my-elb"
  subnets = ["${aws_subnet.my_public_subnet.id}"]
  security_groups = ["${aws_security_group.elb_securitygroup.id}"]
 listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }
  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    target = "HTTP:80/"
    interval = 30
  }

  cross_zone_load_balancing = true
  connection_draining = true
  connection_draining_timeout = 400
  tags {
    Name = "my-elb"
  }
}