terraform {
  backend "s3" {
    bucket = "UNIQUE BUCKETNAME"
    key = "terraform/statefile"
  }
}