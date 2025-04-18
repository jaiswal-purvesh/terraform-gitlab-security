package security

deny[msg] {
  input.resource_type == "aws_ebs_volume"
  not input.resource.encrypted
  msg := sprintf("EBS volume '%s' must be encrypted", [input.resource.name])
}
