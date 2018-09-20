provider "aws" {
  region = "${var.aws_region}"
}

terraform {
  backend "s3" {
    bucket = "ecs-ecr-tfstate"
    key = "ecs.tfstate"
    region = "${var.aws_region}"
  }
}
