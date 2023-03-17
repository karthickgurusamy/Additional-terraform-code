provider "aws" {
  region     = "us-east-1"
}

resource "aws_s3_bucket" "bucket" {
  count = 3

bucket = "lithiksha0303-$
{count.index}"
 acl = "public"
 versioning {
  enabled = true
}

 tags = {
   Name "lithiksha@0303-$
{count.index}"
  Environement = "Production"
}
}

