variable "access_key" {}
variable "secret_key" {}
variable "account_id" {}
variable "region" {
  default = "us-east-1"
  }

variable "webbucketname" {
  default = "oguzdag-pollywebsite"
}

variable "audiobucketname" {
  default = "oguzdag-pollyaudiofiles"
}

variable "dbtablename" {
  default = "posts"
}