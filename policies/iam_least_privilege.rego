package security

deny[msg] {
  input.resource_type == "aws_iam_policy"
  input.resource.policy.Statement[_].Effect == "Allow"
  input.resource.policy.Statement[_].Action == "*"
  input.resource.policy.Statement[_].Resource == "*"
  msg := sprintf("IAM policy '%s' allows full access with '*'", [input.resource.name])
}
