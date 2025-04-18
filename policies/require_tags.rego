package security

required_tags = ["Name", "Environment", "Application"]

deny[msg] {
  some tag
  tag = required_tags[_]
  not input.resource.tags[tag]
  msg := sprintf("Missing required tag: %s in resource %s", [tag, input.resource.name])
}
