output "ecr_repository" {
  value = "${aws_ecr_repository.ecr_repo_ozi.repository_url}"
}

output "elb_dns" {
  value = "${aws_elb.ec2_load_balancer.dns_name}"
}
