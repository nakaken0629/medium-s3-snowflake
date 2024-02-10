data "aws_iam_policy_document" "s3_read" {
  statement {
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:GetObjectVersion"
    ]
    resources = ["${var.s3_bucket_arn}/*"]
  }
  statement {
    effect = "Allow"
    actions = [
      "s3:ListBucket",
      "s3:GetBucketLocation"
    ]
    resources = [var.s3_bucket_arn]
  }
}

resource "aws_iam_policy" "s3_read" {
  name   = "my-policy-s3-read"
  policy = data.aws_iam_policy_document.s3_read.json
}

data "aws_iam_policy_document" "snowflake" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "AWS"
      identifiers = [snowflake_storage_integration.mysite.storage_aws_iam_user_arn]
    }
    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"
      values   = [snowflake_storage_integration.my_integration.storage_aws_external_id]
    }
  }
}

resource "aws_iam_role" "snowflake" {
  name               = "my-role-snowflake"
  assume_role_policy = data.aws_iam_policy_document.snowflake.json
}

resource "aws_iam_role_policy_attachment" "s3_read_for_snowflake" {
  role       = aws_iam_role.snowflake.name
  policy_arn = aws_iam_policy.s3_read.arn
}
