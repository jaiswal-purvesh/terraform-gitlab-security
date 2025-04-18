package security

deny[msg] {
  input.resource_type == "aws_security_group"
  input.resource.cidr_blocks[_] == "0.0.0.0/0"
  msg := "Security group allows public access (0.0.0.0/0)"
}
