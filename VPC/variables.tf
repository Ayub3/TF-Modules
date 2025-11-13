variable "aws_vpc" {
  type = object({
    name                 = string
    cidr_block           = string
    enable_dns_support   = bool
    enable_dns_hostnames = bool
    tags                 = map(string)
  })
}

variable "public_cidr_block" {
  type    = list(string)
  default = []
}

variable "private_cidr_block" {
  type    = list(string)
  default = []
}

variable "database_cidr_block" {
  type    = list(string)
  default = []
}

variable "availability_zone" {
  type    = list(string)
  default = []
}

variable "aws_public_subnet_name" {
  type    = string
  default = "public_subnet"
}

variable "aws_private_subnet_name" {
  type    = string
  default = "private_subnet"
}

variable "aws_db_subnet_name" {
  type    = string
  default = "db_subnet"
}

variable "public_rt_name" {
  type    = string
  default = "public_rt"
}

variable "private_rt_name" {
  type    = string
  default = "private_rt"
}