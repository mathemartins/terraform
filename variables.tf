variable "project_id" {
  description = "Your GCP Project ID"
  default     = "jetbinder"
}

variable "region" {
  description = "GCP region for deployment"
  default     = "us-east1"
}

variable "availability_zones" {
  type        = list(string)
  description = "List of availability zones to use"
  default     = ["us-east1-b", "us-east1-c", "us-east1-d"]
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnets_cidr" {
  type        = list(string)
  description = "CIDR blocks for public subnets"
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "private_subnets_cidr" {
  type        = list(string)
  description = "CIDR blocks for private subnets"
  default     = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]
}
