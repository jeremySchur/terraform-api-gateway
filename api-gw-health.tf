resource "aws_api_gateway_resource" "learning-terraform-api-health" {
  rest_api_id = aws_api_gateway_rest_api.learning-terraform-api.id
  parent_id   = aws_api_gateway_rest_api.learning-terraform-api.root_resource_id
  path_part   = "health"
}

resource "aws_api_gateway_method" "learning-terraform-api-health-get" {
  rest_api_id   = aws_api_gateway_rest_api.learning-terraform-api.id
  resource_id   = aws_api_gateway_resource.learning-terraform-api-health.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "learning-terraform-api-health-get" {
  rest_api_id             = aws_api_gateway_rest_api.learning-terraform-api.id
  resource_id             = aws_api_gateway_resource.learning-terraform-api-health.id
  http_method             = aws_api_gateway_method.learning-terraform-api-health-get.http_method
  integration_http_method = "GET"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.learning-terraform.invoke_arn
}

resource "aws_api_gateway_method" "learning-terraform-api-health-options" {
  rest_api_id   = aws_api_gateway_rest_api.learning-terraform-api.id
  resource_id   = aws_api_gateway_resource.learning-terraform-api-health.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "learning-terraform-api-health-options" {
  rest_api_id = aws_api_gateway_rest_api.learning-terraform-api.id
  resource_id = aws_api_gateway_resource.learning-terraform-api-health.id
  http_method = aws_api_gateway_method.learning-terraform-api-health-options.http_method
  type        = "MOCK"
  request_templates = {
    "application/json" = ""
  }
}

resource "aws_api_gateway_integration_response" "cors_response" {
  depends_on = [aws_api_gateway_integration.learning-terraform-api-health-options]

  rest_api_id = aws_api_gateway_rest_api.learning-terraform-api.id
  resource_id = aws_api_gateway_resource.learning-terraform-api-health.id
  http_method = aws_api_gateway_method.learning-terraform-api-health-options.http_method
  status_code = "200"

  response_templates = {
    "application/json" = ""
  }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,Authorization,X-Amz-Date,X-Api-Key,X-Amz-Security-Token'"
    "method.response.header.Access-Control-Allow-Methods" = "'DELETE,GET,HEAD,OPTIONS,PATCH,POST,PUT'"
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }
}

resource "aws_api_gateway_method_response" "cors_options" {
  rest_api_id = aws_api_gateway_rest_api.learning-terraform-api.id
  resource_id = aws_api_gateway_resource.learning-terraform-api-health.id
  http_method = aws_api_gateway_method.learning-terraform-api-health-options.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Allow-Origin"  = true
  }
}