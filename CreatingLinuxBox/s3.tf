resource "aws_s3_bucket" "ozi_bucket" {
    bucket = "ozi-terraform-test-bucket"
    acl = "private"

    tags {
        Name = "ozi-terraform-test-bucket"
    }
}
