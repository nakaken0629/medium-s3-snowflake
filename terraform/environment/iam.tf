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

data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "snowflake" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "AWS"
      identifiers = [data.aws_caller_identity.current.id]   # set dummy value
    }
    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"
      values   = ["xxxxxxxx"]   # set dummy value
    }
  }
}

resource "aws_iam_role" "snowflake" {
  name               = "my-role-snowflake"
  assume_role_policy = data.aws_iam_policy_document.snowflake.json

  lifecycle {
    ignore_changes = [assume_role_policy]   # ignore changing which is created by the operation at the sub directory
  }
}

resource "aws_iam_role_policy_attachment" "s3_read_for_snowflake" {
  role       = aws_iam_role.snowflake.name
  policy_arn = aws_iam_policy.s3_read.arn
}
