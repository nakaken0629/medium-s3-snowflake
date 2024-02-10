output "role_snowflake_id" {
  value = aws_iam_role.snowflake.id
}

output "role_snowflake_arn" {
  value = aws_iam_role.snowflake.arn
}

output "s3_bucket_url" {
  value = var.s3_bucket_url
}
