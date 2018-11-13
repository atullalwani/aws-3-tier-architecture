resource "aws_iam_role_policy" "iam_policy_for_accessing_s3" {
  name = "iam_policy_s3_access"
  role = "${aws_iam_role.iam_ec2_role.id}"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::${var.S3_BUCKET_NAME}/*"
        }
    ]
}
EOF
}
