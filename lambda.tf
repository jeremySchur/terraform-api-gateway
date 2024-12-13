resource "aws_lambda_function" "learning-terraform" {
  filename      = "./code.zip"
  function_name = "learning-terraform-lambda"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "index.handler"

  source_code_hash = filebase64sha256("./code.zip")

  runtime = "nodejs22.x"

  environment {
    variables = {
      JWT_ACCESS_SECRET = var.JWT_ACCESS_SECRET
    }
  }
}