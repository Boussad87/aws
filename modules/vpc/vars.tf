
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  type = list
  default= ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidr" {
  type = list
  default= ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "availability_zone_names" {
  type    = list
  default = ["us-west-1c", "us-west-1b"]
