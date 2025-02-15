variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "my-vpc"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
}

variable "public_subnet_az" {
  description = "Availability zone for the public subnet"
  type        = string
}

variable "private_subnet_1_cidr" {
  description = "CIDR block for private subnet 1"
  type        = string
}

variable "private_subnet_1_az" {
  description = "Availability zone for private subnet 1"
  type        = string
}

variable "private_subnet_2_cidr" {
  description = "CIDR block for private subnet 2"
  type        = string
}

variable "private_subnet_2_az" {
  description = "Availability zone for private subnet 2"
  type        = string
}
