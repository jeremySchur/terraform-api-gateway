data "aws_caller_identity" "current" {}

resource "aws_iam_role_policy" "iam_cloudwatch_policy_for_lambda" {
  name = "iam_cloudwatch_policy_for_lambda"
  role = aws_iam_role.iam_for_lambda.id
  policy = templatefile("${path.module}/iam-policy.json", {
    region     = var.region,
    account_id = data.aws_caller_identity.current.account_id
  })
}


