resource "aws_ecs_cluster" "main_cluster" {
  name = "my-ecs-cluster"
}

# health_check target might cause trouble

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
