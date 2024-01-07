variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "vpc_name" {
  type    = string
  default = "demo-vpc"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "private_subnets" {
  default = {
    "private_subnet_1" = 1
    "private_subnet_2" = 2
    "private_subnet_3" = 3
  }
}

variable "public_subnets" {
  default = {
    "public_subnet_1" = 1
    "public_subnet_2" = 2
    "public_subnet_3" = 3
  }
}

variable "subnet_cidr" {
  description = "CIDR block for variable subnet"
  default     = "10.0.250.0/24"
  type        = string
  validation {
    condition     = can(regex("^10\\.0\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.0/24$", var.subnet_cidr))
    error_message = "CIDR block must be within the range 10.0.0.0/8 and specific to the 10.0.x.x subnet."
  }
}


variable "subnet_availability_zone" {
  description = "The subnet variable availability zone"
  type        = string
}

variable "subnet_auto_ip" {
  description = "The subnet automatic Ip Address"
  type        = bool
  default     = true
}

variable "environment" {
  description = "The environment we are working on"
  type        = string
  default     = "dev"
}