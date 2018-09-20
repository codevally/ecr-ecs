variable "aws_region" {
  description = "The AWS region to create things in."
  default     = "ap-southeast-2"
}

variable "availability_zones" {
  default     = "ap-southeast-2a,ap-southeast-2b,ap-southeast-2c"
  description = "List of availability zones, use AWS CLI to find your "
}

variable "key_name" {
  description = "Name of AWS key pair"
  default = "ecs"	
}

