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
  request_parameters = { "method.request.querystring.postId" = true }
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
  request_templates {
    "application/xml" = <<EOF
{
    "postId" : "$input.params('postId')"
}
EOF
  }  
  integration_http_method = "GET"  
  type                    = "AWS"
  uri                     = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/arn:aws:lambda:${var.region}:${var.account_id}:function:${aws_lambda_function.getpostslambda.arn}/invocations"
  #uri = "${aws_lambda_function.getpostslambda.function_name}"
}

resource "aws_api_gateway_method_response" "200" {
  rest_api_id             = "${aws_api_gateway_rest_api.postreaderapi.id}"
  resource_id             = "${aws_api_gateway_rest_api.postreaderapi.root_resource_id}"
  http_method             = "${aws_api_gateway_method.getpost.http_method}"
  status_code = "200"
  depends_on = [
    "aws_api_gateway_integration.getpostintegration"
  ]
  response_models {
    "application/json" = "Empty"
  }
  response_parameters = { "method.response.header.Access-Control-Allow-Origin" = true  }
}

resource "aws_api_gateway_integration_response" "ResourceMethodIntegration200" {
  rest_api_id             = "${aws_api_gateway_rest_api.postreaderapi.id}"
  resource_id             = "${aws_api_gateway_rest_api.postreaderapi.root_resource_id}"
  http_method             = "${aws_api_gateway_method.getpost.http_method}"
  status_code = "${aws_api_gateway_method_response.200.status_code}"
  response_parameters = { "method.response.header.Access-Control-Allow-Origin" = "'*'"  }
  depends_on = [
    "aws_api_gateway_integration.getpostintegration"
  ]
  response_templates {
    "application/json" = ""
  }  
}

resource "aws_api_gateway_method_response" "200post" {
  rest_api_id             = "${aws_api_gateway_rest_api.postreaderapi.id}"
  resource_id             = "${aws_api_gateway_rest_api.postreaderapi.root_resource_id}"
  http_method             = "${aws_api_gateway_method.newpost.http_method}"
  status_code = "200"
  depends_on = [
    "aws_api_gateway_integration.newpostintegration"
  ]
  response_models {
    "application/json" = "Empty"
  }
  response_parameters = { "method.response.header.Access-Control-Allow-Origin" = true  }
}

resource "aws_api_gateway_integration_response" "ResourceMethodIntegration200post" {
  rest_api_id             = "${aws_api_gateway_rest_api.postreaderapi.id}"
  resource_id             = "${aws_api_gateway_rest_api.postreaderapi.root_resource_id}"
  http_method             = "${aws_api_gateway_method.newpost.http_method}"
  status_code = "${aws_api_gateway_method_response.200post.status_code}"
  response_parameters = { "method.response.header.Access-Control-Allow-Origin" = "'*'"  }
  depends_on = [
    "aws_api_gateway_integration.newpostintegration"
  ]
  response_templates {
    "application/json" = ""
  }  
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
