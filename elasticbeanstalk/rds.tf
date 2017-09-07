resource "aws_db_parameter_group" "ozi_mariadb_parameters" {
    name = "mariadb-params"
    family = "mariadb10.1"
    description = "MariaDB parameter group"

    parameter {
      name = "max_allowed_packet"
      value = "16777216"
   }

}


resource "aws_db_instance" "mariadb" {
  allocated_storage    = 100    # 100 GB of storage, gives us more IOPS than a lower number
  engine               = "mariadb"
  engine_version       = "10.1.14"
  instance_class       = "db.t2.small"    # use micro if you want to use the free tier
  identifier           = "mariadb"
  name                 = "mydatabase" # database name
  username             = "root"   # username
  password             = "${var.RDS_PASSWORD}" # password
  db_subnet_group_name = "${aws_db_subnet_group.rds_db_subnet.name}"
  parameter_group_name = "${aws_db_parameter_group.ozi_mariadb_parameters.name}"
  multi_az             = "false"     # set to true to have high availability: 2 instances synchronized with each other
  vpc_security_group_ids = ["${aws_security_group.mariadb_security_group.id}"]
  storage_type         = "gp2"
  backup_retention_period = 30    # how long you’re going to keep your backups
  availability_zone = "${aws_subnet.private_subnet_zone1.availability_zone}"   # prefered AZ
  tags {
      Name = "my-mariadb-instance"
  }
}