resource "aws_api_gateway_method" "ResourceOptions" {
  rest_api_id = "${aws_api_gateway_rest_api.postreaderapi.id}"
  resource_id  = "${aws_api_gateway_rest_api.postreaderapi.root_resource_id}"
  http_method = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "ResourceOptionsIntegration" {
  rest_api_id = "${aws_api_gateway_rest_api.postreaderapi.id}"
  resource_id  = "${aws_api_gateway_rest_api.postreaderapi.root_resource_id}"
  http_method = "${aws_api_gateway_method.ResourceOptions.http_method}"
  type = "MOCK"
  request_templates = { 
    "application/json" = <<PARAMS
{ "statusCode": 200 }
PARAMS
  }
}

resource "aws_api_gateway_method_response" "ResourceOptions200" {
  rest_api_id = "${aws_api_gateway_rest_api.postreaderapi.id}"
  resource_id  = "${aws_api_gateway_rest_api.postreaderapi.root_resource_id}"
  http_method = "OPTIONS"
  status_code = "200"
  depends_on = ["aws_api_gateway_integration.ResourceOptionsIntegration"]
  response_models = { "application/json" = "Empty" }
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin" = true
  }
}

resource "aws_api_gateway_integration_response" "ResourceOptionsIntegrationResponse" {
  rest_api_id = "${aws_api_gateway_rest_api.postreaderapi.id}"
  resource_id  = "${aws_api_gateway_rest_api.postreaderapi.root_resource_id}"
  http_method = "${aws_api_gateway_method.ResourceOptions.http_method}"
  depends_on = ["aws_api_gateway_method.ResourceOptions","aws_api_gateway_integration.ResourceOptionsIntegration"]
  status_code = "200"
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'POST,GET,OPTIONS'",
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }
  response_templates {
    "application/json" = ""
  }   
}

