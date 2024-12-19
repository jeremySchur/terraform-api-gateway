resource "aws_api_gateway_resource" "learning-terraform-api-register" {
  rest_api_id = aws_api_gateway_rest_api.learning-terraform-api.id
  parent_id   = aws_api_gateway_rest_api.learning-terraform-api.root_resource_id
  path_part   = "register"
}

resource "aws_api_gateway_method" "learning-terraform-api-register-post" {
  rest_api_id   = aws_api_gateway_rest_api.learning-terraform-api.id
  resource_id   = aws_api_gateway_resource.learning-terraform-api-register.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "learning-terraform-api-register-post" {
  rest_api_id             = aws_api_gateway_rest_api.learning-terraform-api.id
  resource_id             = aws_api_gateway_resource.learning-terraform-api-register.id
  http_method             = aws_api_gateway_method.learning-terraform-api-register-post.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.learning-terraform.invoke_arn
}

resource "aws_api_gateway_method_response" "learning-terraform-api-register-post" {
  rest_api_id = aws_api_gateway_rest_api.learning-terraform-api.id
  resource_id = aws_api_gateway_resource.learning-terraform-api-register.id
  http_method = aws_api_gateway_method.learning-terraform-api-register-post.http_method
  status_code = "200"

  response_models = {
    "application/json" = "Empty"
  }
}