resource "aws_api_gateway_rest_api" "postreaderapi" {
  name = "PostReader"
  description = "Post Reader API"
}

resource "aws_api_gateway_method" "newpost" {
  rest_api_id = "${aws_api_gateway_rest_api.postreaderapi.id}"
  resource_id  = "${aws_api_gateway_rest_api.postreaderapi.root_resource_id}"
  http_method = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_method" "getpost" {
  rest_api_id = "${aws_api_gateway_rest_api.postreaderapi.id}"
  resource_id  = "${aws_api_gateway_rest_api.postreaderapi.root_resource_id}"
  http_method = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "newpostintegration" {
  rest_api_id             = "${aws_api_gateway_rest_api.postreaderapi.id}"
  resource_id             = "${aws_api_gateway_rest_api.postreaderapi.root_resource_id}"
  http_method             = "${aws_api_gateway_method.newpost.http_method}"
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/arn:aws:lambda:${var.region}:${var.account_id}:function:${aws_lambda_function.newpostlambda.arn}/invocations"
}

resource "aws_api_gateway_integration" "getpostintegration" {
  rest_api_id             = "${aws_api_gateway_rest_api.postreaderapi.id}"
  resource_id             = "${aws_api_gateway_rest_api.postreaderapi.root_resource_id}"
  http_method             = "${aws_api_gateway_method.getpost.http_method}"
  integration_http_method = "GET"
  type                    = "AWS"
  uri                     = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/arn:aws:lambda:${var.region}:${var.account_id}:function:${aws_lambda_function.getpostslambda.arn}/invocations"
}

resource "aws_api_gateway_deployment" "example_deployment_dev" {
  depends_on = [
    "aws_api_gateway_method.newpost",
    "aws_api_gateway_integration.newpostintegration",
    "aws_api_gateway_method.getpost",
    "aws_api_gateway_integration.getpostintegration"
  ]
  rest_api_id = "${aws_api_gateway_rest_api.postreaderapi.id}"
  stage_name = "dev"
}
