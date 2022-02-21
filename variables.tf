variable "cidr_vpc" {
  description = "CIDR block for the VPC"
  default     = "10.1.0.0/16"
}

variable "cidr_subnet" {
  description = "CIDR block for the subnet"
  default     = "10.1.0.0/24"
}

variable "environment_tag" {
  description = "Environment tag"
  default     = "Learn"
}

variable "aws_region" {
  description = "The AWS region to deploy your instance"
  default     = "eu-west-2"
}

variable "user_name" {
  description = "The user creating this infrastructure"
  default     = "terraform"
}

variable "user_department" {
  description = "The organization the user belongs to: dev, prod, qa"
  default     = "learn"
}

variable "aws_amis" {
  type = map
  default = {
    "eu-west-2" = "ami-0015a39e4b7c0966f"
    "eu-central-1" = "ami-0d527b8c289b4af7f"
    "eu-west-1" = "ami-08ca3fed11864d6bb"
  }
}