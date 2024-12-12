resource "aws_api_gateway_rest_api" "learning-terraform-api" {
  name = "learning-terraform-api"

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_lambda_permission" "apigw_invoke" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.learning-terraform.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.learning-terraform-api.execution_arn}/*/*"
}


resource "aws_api_gateway_deployment" "learning-terraform-api-deployment" {
  rest_api_id = aws_api_gateway_rest_api.learning-terraform-api.id

  depends_on = [
    aws_api_gateway_integration.learning-terraform-api-health-get,
    aws_api_gateway_integration.learning-terraform-api-health-options
  ]
}

resource "aws_api_gateway_stage" "learning-terraform-api-stage" {
  stage_name    = "test"
  rest_api_id   = aws_api_gateway_rest_api.learning-terraform-api.id
  deployment_id = aws_api_gateway_deployment.learning-terraform-api-deployment.id
}