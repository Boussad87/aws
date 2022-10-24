resource "aws_s3_bucket" "my_bucket" {
  bucket = "boussad-bucket"
  region = "us-west-1"
  acl    = "private"
  }