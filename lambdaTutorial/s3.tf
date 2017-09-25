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

resource "aws_s3_bucket_object" "indexfile" {
  bucket = "${var.webbucketname}"
  key    = "index.html"
  source = "code/index.html"
  content_type = "text/html"
  depends_on = ["aws_api_gateway_deployment.example_deployment_dev"]
}

resource "aws_s3_bucket_object" "scriptsfile" {
  bucket = "${var.webbucketname}"
  key    = "scripts.js"
  content = "${data.template_file.scriptsfiletemplate.rendered}"
  content_type = "application/javascript"
  depends_on = ["aws_api_gateway_deployment.example_deployment_dev"]
}

resource "aws_s3_bucket_object" "stylesfile" {
  bucket = "${var.webbucketname}"
  key    = "styles.css"
  source = "code/styles.css"
  content_type = "text/css"
  depends_on = ["aws_api_gateway_deployment.example_deployment_dev"]
}

data "template_file" "bucketpolicy" {
  template = "${file("json/bucketpolicy.json")}"

  vars {
    bucket_name = "${var.webbucketname}"
  }
}

data "template_file" "scriptsfiletemplate" {
  template = "${file("code/scripts.js")}"
  depends_on = ["aws_api_gateway_deployment.example_deployment_dev"]
  vars {
    api_endpoint = "https://${aws_api_gateway_deployment.example_deployment_dev.rest_api_id}.execute-api.${var.region}.amazonaws.com/${aws_api_gateway_deployment.example_deployment_dev.stage_name}"
  }
}