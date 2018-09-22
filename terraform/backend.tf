provider "aws" {
  region = "${var.aws_region}"
}

terraform {
  backend "s3" {}
}

#
# Get the availability zones for our given region
# https://www.terraform.io/docs/providers/aws/d/availability_zones.html
#
data "aws_availability_zones" "available" {}
