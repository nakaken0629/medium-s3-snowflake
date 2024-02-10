# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# __generated__ by Terraform from "my-role-snowflake"
resource "aws_iam_role" "snowflake" {
  assume_role_policy    = data.aws_iam_policy_document.snowflake.json
  description           = null
  force_detach_policies = false
  managed_policy_arns   = ["arn:aws:iam::129119569090:policy/my-policy-s3-read"]
  max_session_duration  = 3600
  name                  = "my-role-snowflake"
  name_prefix           = null
  path                  = "/"
  permissions_boundary  = null
  tags                  = {}
  tags_all              = {}
}
