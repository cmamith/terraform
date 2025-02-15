variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "subnet_id" {
  type        = string
  description = "The subnet ID where the instance will be deployed"
}

variable "public_ip" {
  type    = bool
  default = false
}

variable "instance_name" {
  type    = string
  default = "example-instance"
}