resource "aws_s3_bucket" "webbucket" {
    bucket      =   "${var.webbucketname}"
    region      =   "${var.region}"
    policy      =   "${data.template_file.bucketpolicy.rendered}"
    force_destroy       =   true
    website {
        index_document      =   "index.html"
        error_document      =   "error.html"
    }
}

resource "aws_s3_bucket" "audiobucket" {
    bucket      =   "${var.audiobucketname}"
    region      =   "${var.region}"
    force_destroy       =   true
}

data "template_file" "bucketpolicy" {
  template = "${file("bucketpolicy.json")}"

  vars {
    bucket_name = "${var.webbucketname}"
  }
}