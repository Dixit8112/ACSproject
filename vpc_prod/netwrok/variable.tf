variable "cidr_name" {
  description = "CIDR Name"
  type        = string
}

variable "vpc_name" {
  description = "VPC Name"
  type        = string
}

variable "public_subnet_1" {
  description = "The CIDR block for the public subnet-1"
  type        = string
}

variable "public_subnet_2" {
  description = "The CIDR block for the public subnet-2"
  type        = string
}

variable "public_subnet_3" {
  description = "The CIDR block for the public subnet-3"
  type        = string
}

variable "public_subnet_4" {
  description = "The CIDR block for the public subnet-4"
  type        = string
}

variable "private_subnet_1" {
  description = "The CIDR block for the private subnet-1"
  type        = string
}

variable "private_subnet_2" {
  description = "The CIDR block for the private subnet-2"
  type        = string
}

variable "availability_zone1" {
  description = "The availability zone for subnet set-1"
  type        = string
}

variable "availability_zone2" {
  description = "The availability zone for subnet set-2"
  type        = string
}

variable "availability_zone3" {
  description = "The availability zone for subnet set-3"
  type        = string
}

variable "availability_zone4" {
  description = "The availability zone for subnet set-4"
  type        = string
}
