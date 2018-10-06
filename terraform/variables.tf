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

variable "webapp_docker_image_name" {
    default = "training/webapp_docker_image"
    description = "Docker image from ECR"
}

variable "webapp_docker_image_tag" {
    default = "latest"
    description = "Docker image version to pull (from tag)"
}

variable "count_webapp" {
    default = 2
    description = "Number of webapp tasks to run"
}

variable "minimum_healthy_percent_webapp" {
    default = 50
    description = "ECS minimum_healthy_percent configuration, set it lower than 100 to allow rolling update without adding new instances"
}

variable "desired_capacity_on_demand" {
    default = 2
    description = "Number of instance to run"
}

variable "instance_type" {
    default = "t2.micro"
    description = "EC2 instance type to use"
}