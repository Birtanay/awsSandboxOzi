## It is failing

### Current Error

It is creating infrastructure fine. But ecs-service cannot connect to ec2 instances. When you check service events, this error shows up. It might be related with ecr repository

service hello-world was unable to place a task because no container instance met all of its requirements. Reason: No Container Instances were found in your cluster.

### Error (using custom vpc settings, it might be related with not to create subnet for each available zone in region)

Error applying plan:

1 error(s) occurred:

* aws_autoscaling_group.ecs_autoscaling_group: aws_autoscaling_group.ecs_autoscaling_group: diffs didn't match during apply. This is a bug with Terraform and should be reported as a GitHub Issue.

Please include the following information in your report:

    Terraform Version: 0.10.0
    Resource ID: aws_autoscaling_group.ecs_autoscaling_group
    Mismatch reason: attribute mismatch: availability_zones.3569565595
    Diff One (usually from plan): *terraform.InstanceDiff{mu:sync.Mutex{state:0, sema:0x0}, Attributes:map[string]*terraform.ResourceAttrDiff{"min_size":*terraform.ResourceAttrDiff{Old:"", New:"3", NewComputed:false, NewRemoved:false, NewExtra:interface {}(nil), RequiresNew:false, Sensitive:false, Type:0x0}, "launch_configuration":*terraform.ResourceAttrDiff{Old:"", New:"ecs-launch-configuration", NewComputed:false, NewRemoved:false, NewExtra:interface {}(nil), RequiresNew:false, Sensitive:false, Type:0x0}, "max_size":*terraform.ResourceAttrDiff{Old:"", New:"5", NewComputed:false, NewRemoved:false, NewExtra:interface {}(nil), RequiresNew:false, Sensitive:false, Type:0x0}, "availability_zones.#":*terraform.ResourceAttrDiff{Old:"", New:"1", NewComputed:false, NewRemoved:false, NewExtra:interface {}(nil), RequiresNew:false, Sensitive:false, Type:0x0}, "health_check_grace_period":*terraform.ResourceAttrDiff{Old:"", New:"300", NewComputed:false, NewRemoved:false, NewExtra:interface {}(nil), RequiresNew:false, Sensitive:false, Type:0x0}, "desired_capacity":*terraform.ResourceAttrDiff{Old:"", New:"4", NewComputed:false, NewRemoved:false, NewExtra:interface {}(nil), RequiresNew:false, Sensitive:false, Type:0x0}, "arn":*terraform.ResourceAttrDiff{Old:"", New:"", NewComputed:true, NewRemoved:false, NewExtra:interface {}(nil), RequiresNew:false, Sensitive:false, Type:0x0}, "default_cooldown":*terraform.ResourceAttrDiff{Old:"", New:"", NewComputed:true, NewRemoved:false, NewExtra:interface {}(nil), RequiresNew:false, Sensitive:false, Type:0x0}, "protect_from_scale_in":*terraform.ResourceAttrDiff{Old:"", New:"false", NewComputed:false, NewRemoved:false, NewExtra:interface {}(nil), RequiresNew:false, Sensitive:false, Type:0x0}, "health_check_type":*terraform.ResourceAttrDiff{Old:"", New:"EC2", NewComputed:false, NewRemoved:false, NewExtra:interface {}(nil), RequiresNew:false, Sensitive:false, Type:0x0}, "metrics_granularity":*terraform.ResourceAttrDiff{Old:"", New:"1Minute", NewComputed:false, NewRemoved:false, NewExtra:interface {}(nil), RequiresNew:false, Sensitive:false, Type:0x0}, "name":*terraform.ResourceAttrDiff{Old:"", New:"ecs-autoscaling-group", NewComputed:false, NewRemoved:false, NewExtra:interface {}(nil), RequiresNew:true, Sensitive:false, Type:0x0}, "wait_for_capacity_timeout":*terraform.ResourceAttrDiff{Old:"", New:"10m", NewComputed:false, NewRemoved:false, NewExtra:interface {}(nil), RequiresNew:false, Sensitive:false, Type:0x0}, "vpc_zone_identifier.#":*terraform.ResourceAttrDiff{Old:"", New:"", NewComputed:true, NewRemoved:false, NewExtra:interface {}(nil), RequiresNew:false, Sensitive:false, Type:0x0}, "target_group_arns.#":*terraform.ResourceAttrDiff{Old:"", New:"", NewComputed:true, NewRemoved:false, NewExtra:interface {}(nil), RequiresNew:false, Sensitive:false, Type:0x0}, "availability_zones.3569565595":*terraform.ResourceAttrDiff{Old:"", New:"us-east-1a", NewComputed:false, NewRemoved:false, NewExtra:interface {}(nil), RequiresNew:false, Sensitive:false, Type:0x0}, "load_balancers.#":*terraform.ResourceAttrDiff{Old:"", New:"", NewComputed:true, NewRemoved:false, NewExtra:interface {}(nil), RequiresNew:false, Sensitive:false, Type:0x0}, "force_delete":*terraform.ResourceAttrDiff{Old:"", New:"false", NewComputed:false, NewRemoved:false, NewExtra:interface {}(nil), RequiresNew:false, Sensitive:false, Type:0x0}}, Destroy:false, DestroyDeposed:false, DestroyTainted:false, Meta:map[string]interface {}(nil)}
    Diff Two (usually from apply): *terraform.InstanceDiff{mu:sync.Mutex{state:0, sema:0x0}, Attributes:map[string]*terraform.ResourceAttrDiff{"vpc_zone_identifier.476101540":*terraform.ResourceAttrDiff{Old:"", New:"vpc-90184de9", NewComputed:false, NewRemoved:false, NewExtra:interface {}(nil), RequiresNew:false, Sensitive:false, Type:0x0}, "desired_capacity":*terraform.ResourceAttrDiff{Old:"", New:"4", NewComputed:false, NewRemoved:false, NewExtra:interface {}(nil), RequiresNew:false, Sensitive:false, Type:0x0}, "force_delete":*terraform.ResourceAttrDiff{Old:"", New:"false", NewComputed:false, NewRemoved:false, NewExtra:interface {}(nil), RequiresNew:false, Sensitive:false, Type:0x0}, "protect_from_scale_in":*terraform.ResourceAttrDiff{Old:"", New:"false", NewComputed:false, NewRemoved:false, NewExtra:interface {}(nil), RequiresNew:false, Sensitive:false, Type:0x0}, "health_check_grace_period":*terraform.ResourceAttrDiff{Old:"", New:"300", NewComputed:false, NewRemoved:false, NewExtra:interface {}(nil), RequiresNew:false, Sensitive:false, Type:0x0}, "arn":*terraform.ResourceAttrDiff{Old:"", New:"", NewComputed:true, NewRemoved:false, NewExtra:interface {}(nil), RequiresNew:false, Sensitive:false, Type:0x0}, "load_balancers.#":*terraform.ResourceAttrDiff{Old:"", New:"", NewComputed:true, NewRemoved:false, NewExtra:interface {}(nil), RequiresNew:false, Sensitive:false, Type:0x0}, "health_check_type":*terraform.ResourceAttrDiff{Old:"", New:"EC2", NewComputed:false, NewRemoved:false, NewExtra:interface {}(nil), RequiresNew:false, Sensitive:false, Type:0x0}, "target_group_arns.#":*terraform.ResourceAttrDiff{Old:"", New:"", NewComputed:true, NewRemoved:false, NewExtra:interface {}(nil), RequiresNew:false, Sensitive:false, Type:0x0}, "launch_configuration":*terraform.ResourceAttrDiff{Old:"", New:"ecs-launch-configuration", NewComputed:false, NewRemoved:false, NewExtra:interface {}(nil), RequiresNew:false, Sensitive:false, Type:0x0}, "default_cooldown":*terraform.ResourceAttrDiff{Old:"", New:"", NewComputed:true, NewRemoved:false, NewExtra:interface {}(nil), RequiresNew:false, Sensitive:false, Type:0x0}, "metrics_granularity":*terraform.ResourceAttrDiff{Old:"", New:"1Minute", NewComputed:false, NewRemoved:false, NewExtra:interface {}(nil), RequiresNew:false, Sensitive:false, Type:0x0}, "max_size":*terraform.ResourceAttrDiff{Old:"", New:"5", NewComputed:false, NewRemoved:false, NewExtra:interface {}(nil), RequiresNew:false, Sensitive:false, Type:0x0}, "name":*terraform.ResourceAttrDiff{Old:"", New:"ecs-autoscaling-group", NewComputed:false, NewRemoved:false, NewExtra:interface {}(nil), RequiresNew:true, Sensitive:false, Type:0x0}, "wait_for_capacity_timeout":*terraform.ResourceAttrDiff{Old:"", New:"10m", NewComputed:false, NewRemoved:false, NewExtra:interface {}(nil), RequiresNew:false, Sensitive:false, Type:0x0}, "min_size":*terraform.ResourceAttrDiff{Old:"", New:"3", NewComputed:false, NewRemoved:false, NewExtra:interface {}(nil), RequiresNew:false, Sensitive:false, Type:0x0}, "vpc_zone_identifier.#":*terraform.ResourceAttrDiff{Old:"", New:"1", NewComputed:false, NewRemoved:false, NewExtra:interface {}(nil), RequiresNew:false, Sensitive:false, Type:0x0}}, Destroy:false, DestroyDeposed:false, DestroyTainted:false, Meta:map[string]interface {}(nil)}

Also include as much context as you can about your config, state, and the steps you performed to trigger this error.

Terraform does not automatically rollback in the face of errors.
Instead, your Terraform state file has been partially updated with
any resources that successfully completed. Please address the error
above and apply again to incrementally change your infrastructure.


## Next error

When you remove available_zones from aws_autoscaling_group it completes, but this time service under ecs cluster cannot find any instance to run tasks on. 

## Other errors

### Error

* aws_launch_configuration.ecs_launch_configuration: Error creating launch configuration: ValidationError: The key pair 'MyKeyPair' does not exist
        status code: 400, request id: 59694c21-8063-11e7-b945-c313b3cdc9e8

### Solution

I created a new keypair and used that

### Error

* aws_autoscaling_group.ecs_autoscaling_group: Error creating AutoScaling Group: ValidationError: The subnet ID 'vpc-113e6b68' does not exist
        status code: 400, request id: 3536d34b-80e9-11e7-b34e-b18df4e78a9b

### Solution

Autoscaling group parameter corrected. previously vpc_zone_identifier was showing vpc id, it is changed to subnet id

### Error

* aws_ecs_service.hello_world_service: InvalidParameterException: Unable to assume role and validate the listeners configured on your load balancer. Please verify that the ECS service role being passed has the proper permissions.
        status code: 400, request id: 637117f9-8275-11e7-b3c1-43cdf17362f4 "hello-world"
 
### Solution

I don't remember. I am not sure that I resolved this one.
