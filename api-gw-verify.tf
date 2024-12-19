resource "aws_api_gateway_resource" "learning-terraform-api-verify" {
  rest_api_id = aws_api_gateway_rest_api.learning-terraform-api.id
  parent_id   = aws_api_gateway_rest_api.learning-terraform-api.root_resource_id
  path_part   = "verify"
}

resource "aws_api_gateway_method" "learning-terraform-api-verify-post" {
  rest_api_id   = aws_api_gateway_rest_api.learning-terraform-api.id
  resource_id   = aws_api_gateway_resource.learning-terraform-api-verify.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "learning-terraform-api-verify-post" {
  rest_api_id             = aws_api_gateway_rest_api.learning-terraform-api.id
  resource_id             = aws_api_gateway_resource.learning-terraform-api-verify.id
  http_method             = aws_api_gateway_method.learning-terraform-api-verify-post.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.learning-terraform.invoke_arn
}

resource "aws_api_gateway_method_response" "learning-terraform-api-verify-post" {
  rest_api_id = aws_api_gateway_rest_api.learning-terraform-api.id
  resource_id = aws_api_gateway_resource.learning-terraform-api-verify.id
  http_method = aws_api_gateway_method.learning-terraform-api-verify-post.http_method
  status_code = "200"

  response_models = {
    "application/json" = "Empty"
  }
}