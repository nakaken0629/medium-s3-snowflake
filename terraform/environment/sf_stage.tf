resource "snowflake_storage_integration" "mysite" {
  type                      = "EXTERNAL_STAGE"
  storage_provider          = "S3"
  enabled                   = true
  storage_aws_role_arn      = aws_iam_role.snowflake.arn
  name                      = "MY_INTEGRATION"
  storage_allowed_locations = ["${var.s3_bucket_url}/"]
}