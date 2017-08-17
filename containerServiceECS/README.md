## It is failing

### Error

Error applying plan:

1 error(s) occurred:

* aws_ecs_service.hello_world_service: 1 error(s) occurred:

* aws_ecs_service.hello_world_service: InvalidParameterException: Unable to assume role and validate the listeners configured on your load balancer. Please verify that the ECS service role being passed has the proper permissions.
        status code: 400, request id: 637117f9-8275-11e7-b3c1-43cdf17362f4 "hello-world"

Terraform does not automatically rollback in the face of errors.
Instead, your Terraform state file has been partially updated with
any resources that successfully completed. Please address the error
above and apply again to incrementally change your infrastructure.
