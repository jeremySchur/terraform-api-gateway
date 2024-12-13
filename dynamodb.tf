resource "aws_dynamodb_table" "learning-terraform" {
  name           = "learning-user-login"
  hash_key       = "username"
  read_capacity  = 5
  write_capacity = 5

  attribute {
    name = "username"
    type = "S"
  }
}