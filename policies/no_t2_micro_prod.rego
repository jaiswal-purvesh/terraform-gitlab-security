package security

deny[msg] {
  input.resource_type == "aws_instance"
  input.resource.tags["Environment"] == "prod"
  input.resource.instance_type == "t2.micro"
  msg := "t2.micro is not allowed in production"
}
