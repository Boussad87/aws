resource "aws_iam_role" "s3-mybucket-role" {
    name = "boussad-s3-mybucket-role"
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "s3-mybucket-role-instanceprofile" {
    name = "boussad-s3-mybucket-role"
    role = "${aws_iam_role.s3-mybucket-role.name}"
}

resource "aws_iam_role_policy" "s3-mybucket-role-policy" {
    name = "s3-mybucket-role-policy"
    role = "${aws_iam_role.s3-mybucket-role.id}"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": [
                    "arn:aws:s3:::boussad-bucket",
                    "arn:aws:s3:::boussad-bucket/*"
                  ]
    }
  ]
}
EOF
}
