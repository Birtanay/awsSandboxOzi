# awsSandboxOzi
Several AWS terraform examples

## Don't Forget to Run

1. terraform get
2. terraform init
3. terraform plan -out plan.out
4. terraform apply plan.out
5. terraform destroy

## Creating Linux Box
Simple script that creates Linux box.

### components
aws_instance, aws_security_group, aws_key_pair, aws_iam_role, aws_iam_instance_profile, aws_iam_role_policy, aws_vpc, aws_subnet, aws_internet_gateway, aws_route_table, aws_route_table_association, aws_s3_bucket, aws_ebs_volume, aws_volume_attachment

## Creating Windows Box
Simple script that creates Windows box.

### components
aws_instance, aws_security_group

## Creating Lambda Function of a Python script
Simple script that creates Lambda Function for python. Simply zip py file and put it in same folder.

### components
aws_iam_role, aws_lambda_function

## Creating custom docker container environment
Simple script that creates a custom docker container and related environment 

It is not working

### components
aws_vpc, aws_subnet, aws_internet_gateway, aws_route_table, aws_route_table_association, aws_security_group, aws_ecs_cluster, aws_elb, aws_iam_policy_document, aws_iam_role, aws_iam_role_policy, aws_iam_instance_profile, aws_launch_configuration, aws_autoscaling_group, aws_ecs_task_definition, aws_ecs_service, 

## Creating wordpress environment 
Simple script that creates fully functional wordpress environment

### components
aws_vpc, aws_internet_gateway, aws_eip, aws_subnet, aws_db_subnet_group, aws_nat_gateway, aws_route_table, aws_route_table_association, aws_route53_zone, aws_route53_record, aws_iam_role, aws_iam_role_policy_attachment, aws_iam_instance_profile, aws_security_group_rule, aws_security_group, aws_launch_configuration, aws_autoscaling_group, aws_elb, aws_ecr_repository, aws_ecs_cluster, aws_ecs_service, aws_ecs_task_definition, aws_db_instance, aws_efs_file_system, aws_efs_mount_target, 

## Creating Jenkins workflow system
Simple scrit that creates jenkins workflow system

Working on this

### components
aws_key_pair, s3 backend, aws_instance, aws_vpc, aws_subnet, aws_internet_gateway, aws_route_table, aws_route_table_association, aws_security_group_rule, aws_security_group
