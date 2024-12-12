resource "aws_lambda_function" "learning-terraform" {
  filename      = "${path.module}/code.zip"
  function_name = "learning-terraform-lambda"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "code.lambda_handler"

  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # source_code_hash = "${base64sha256(file("lambda_function_payload.zip"))}"
  source_code_hash = filebase64sha256("${path.module}/code.zip")

  runtime = "nodejs22.x"
}