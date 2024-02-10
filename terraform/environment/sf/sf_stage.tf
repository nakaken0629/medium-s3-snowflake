resource "snowflake_storage_integration" "my_integration" {
  type                      = "EXTERNAL_STAGE"
  storage_provider          = "S3"
  enabled                   = true
  storage_aws_role_arn      = data.terraform_remote_state.base.outputs.role_snowflake_arn
  name                      = "MY_INTEGRATION"
  storage_allowed_locations = ["${data.terraform_remote_state.base.outputs.s3_bucket_url}/"]
}
