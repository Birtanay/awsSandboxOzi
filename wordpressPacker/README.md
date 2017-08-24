# Issues

## Description 

While destroying rds instance, it is giving you error:

Error applying plan:

1 error(s) occurred:

* aws_db_instance.rds_db_instance (destroy): 1 error(s) occurred:

* aws_db_instance.rds_db_instance: DB Instance FinalSnapshotIdentifier is required when a final snapshot is required

Terraform does not automatically rollback in the face of errors.
Instead, your Terraform state file has been partially updated with
any resources that successfully completed. Please address the error
above and apply again to incrementally change your infrastructure.

## Solution

https://github.com/hashicorp/terraform/issues/5417
