resource "aws_vpc" "container_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags {
    Name = "container-vpc"
  }
}

resource "aws_subnet" "container_subnet" {
  vpc_id            = "${aws_vpc.container_vpc.id}"
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags {
    Name = "container-subnet"
  }
}

resource "aws_internet_gateway" "container_internet_gateway" {
  vpc_id = "${aws_vpc.container_vpc.id}"

  tags {
    Name = "container-internet-gateway"
  }
}

resource "aws_route_table" "container_external_route_table" {
  vpc_id = "${aws_vpc.container_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.container_internet_gateway.id}"
  }

  tags {
    Name = "container-external-route-table"
  }
}

resource "aws_route_table_association" "container_subnet_route_association" {
  subnet_id      = "${aws_subnet.container_subnet.id}"
  route_table_id = "${aws_route_table.container_external_route_table.id}"
}

resource "aws_security_group" "ssh_http_from_to_anywhere" {
  name        = "ssh_and_http_from_and_to_anywhere"
  description = "Allow all traffic in and out"

  #vpc_id      = "${aws_vpc.container_vpc.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  lifecycle {
    create_before_destroy = true
  }
  tags {
    Name = "ssh-and-http-from-and-to-anywhere"
  }
}

resource "aws_ecs_cluster" "main_cluster" {
  name = "my-ecs-cluster"
}

# health_check target might cause trouble

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

data "aws_iam_policy_document" "instance_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecs_instance_role" {
  name               = "ecs-instance-role"
  assume_role_policy = "${data.aws_iam_policy_document.instance_assume_role_policy.json}"
}

resource "aws_iam_role_policy" "ecs_instance_role_policy" {
  name   = "ecs-instance-role-policy"
  policy = "${file("AmazonEC2ContainerServiceforEC2Role.json")}"
  role   = "${aws_iam_role.ecs_instance_role.id}"
}

resource "aws_iam_role" "ecs_service_role" {
  name               = "ecs-service-role"
  assume_role_policy = "${data.aws_iam_policy_document.instance_assume_role_policy.json}"
}

resource "aws_iam_role_policy" "ecs_service_role_policy" {
  name   = "ecs-service-role-policy"
  policy = "${file("AmazonEC2ContainerServiceRole.json")}"
  role   = "${aws_iam_role.ecs_service_role.id}"
}

resource "aws_iam_instance_profile" "ecs" {
  name = "ecs-instance-profile"
  role = "${aws_iam_role.ecs_instance_role.name}"
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

data "aws_availability_zones" "all" {}

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

resource "aws_ecs_task_definition" "hello_world_task" {
  family                = "hello-world-container"
  container_definitions = "${file("helloWorldContainer.json")}"
}

resource "aws_ecs_service" "hello_world_service" {
  name            = "hello-world"
  cluster         = "${aws_ecs_cluster.main_cluster.id}"
  task_definition = "${aws_ecs_task_definition.hello_world_task.arn}"
  iam_role        = "${aws_iam_role.ecs_service_role.arn}"
  desired_count   = 4

  load_balancer {
    elb_name       = "${aws_elb.main_load_balancer.id}"
    container_name = "simple-service"
    container_port = 8000
  }
}
