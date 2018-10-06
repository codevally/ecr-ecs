variable "aws_region" {
  description = "The AWS region to create things in."
}

variable "key_name" {
  description = "Name of AWS key pair"
}

variable "name_prefix" {
    default = "demo"
    description = "Name prefix for this environment."
}

/* ECS optimized AMIs per region */
variable "ecs_image_id" {
  default = {
    ap-southeast-2 = "ami-05b48eda7f92aadbe"
  }
}
