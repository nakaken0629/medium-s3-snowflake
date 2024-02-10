import {
  # provider = aws

  to = aws_iam_role.snowflake
  id = data.terraform_remote_state.base.outputs.role_snowflake_id
}

data "aws_iam_policy_document" "snowflake" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "AWS"
      identifiers = [snowflake_storage_integration.my_integration.storage_aws_iam_user_arn]   # 正しい値に置き換える
    }
    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"
      values   = [snowflake_storage_integration.my_integration.storage_aws_external_id]   # 正しい値に置き換える
    }
  }
}
