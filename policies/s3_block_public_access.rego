package security

deny[msg] {
  input.resource_type == "aws_s3_bucket_public_access_block"
  not input.resource.block_public_acls
  msg := "S3 bucket must block public ACLs"
}

deny[msg] {
  input.resource_type == "aws_s3_bucket_public_access_block"
  not input.resource.block_public_policy
  msg := "S3 bucket must block public policy"
}
