resource "aws_iam_role" "iam_ec2_role" {
    name = "iam_ec2_role"
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
      {
          "Action": "sts:AssumeRole",
          "Effect": "Allow",
          "Principal": {
              "Service": "ec2.amazonaws.com"
          }
      }
  ]
}
EOF
}


resource "aws_iam_instance_profile" "s3_access_profile" {
  name = "s3_access_profile"
  role = "${aws_iam_role.iam_ec2_role.name}"
}
