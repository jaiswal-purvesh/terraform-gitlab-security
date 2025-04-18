package security

deny[msg] {
  input.resource_type == "aws_security_group"
  input.resource.ingress[_].cidr_blocks[_] == "0.0.0.0/0"
  msg := sprintf("Ingress rule allows public access in %s", [input.resource.name])
}
