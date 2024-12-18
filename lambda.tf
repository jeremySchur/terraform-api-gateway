data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "${path.module}/api-gw-code"
  output_path = "${path.module}/api-gw-code.zip"
}

resource "aws_lambda_function" "learning-terraform" {
  filename      = data.archive_file.lambda_zip.output_path
  function_name = "learning-terraform-lambda"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "index.handler"

  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  runtime = "nodejs22.x"

  environment {
    variables = {
      JWT_ACCESS_SECRET = var.JWT_ACCESS_SECRET
    }
  }
}