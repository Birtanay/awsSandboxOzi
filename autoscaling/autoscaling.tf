resource "aws_launch_configuration" "ozi_launch_configuration" {
  name_prefix          = "my-launch-configuration"
  image_id             = "${lookup(var.AMIS, var.region)}"
  instance_type        = "t2.micro"
  key_name             = "${aws_key_pair.mykey.key_name}"
  security_groups      = ["${aws_security_group.Tutorial_01_asg.id}"]
}

resource "aws_autoscaling_group" "ozi_asg" {
  name                 = "my-autoscaling"
  vpc_zone_identifier  = ["${aws_subnet.my_public_subnet.id}"]
  launch_configuration = "${aws_launch_configuration.ozi_launch_configuration.name}"
  min_size             = 2
  max_size             = 3
  health_check_grace_period = 300
  health_check_type = "EC2"
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
