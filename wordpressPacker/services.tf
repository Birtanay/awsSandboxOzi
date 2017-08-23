resource "aws_ecr_repository" "ecr_repo_ozi" {
  name = "wordpress_ael"
}

resource "aws_ecs_cluster" "ecs_cluster_ozi" {
  name = "wordpress-cluster"
}

resource "aws_ecs_service" "ecs_service_ozi" {
  name            = "wordpress-service"
  cluster         = "${aws_ecs_cluster.ecs_cluster_ozi.id}"
  desired_count   = 1
  task_definition = "${aws_ecs_task_definition.ecs_task.family}"
}

resource "aws_ecs_task_definition" "ecs_task" {
  family                = "wordpress"
  container_definitions = "${data.template_file.wordpress_task.rendered}"

  volume {
    name      = "storage-container"
    host_path = "/mnt/wordpress"
  }
}

data "template_file" "wordpress_task" {
  template = "${file("wordpress_container.json")}"

  vars {
    repository_url = "${aws_ecr_repository.ecr_repo_ozi.repository_url}"
  }
}

resource "aws_db_instance" "rds" {
  allocated_storage      = 5
  engine                 = "mysql"
  engine_version         = "5.6.27"
  instance_class         = "db.t2.micro"
  name                   = "wordpress"
  username               = "wp"
  password               = "myverystrongpassword"
  db_subnet_group_name   = "${aws_db_subnet_group.rds_db_subnet.name}"
  vpc_security_group_ids = ["${aws_security_group.rds_security_group_ingress.id}"]
}
