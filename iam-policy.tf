resource "aws_iam_role_policy" "iam_cloudwatch_policy_for_lambda" {
  name   = "iam_cloudwatch_policy_for_lambda"
  role   = aws_iam_role.iam_for_lambda.id
  policy = file("${path.module}/iam-policy.json")
}
