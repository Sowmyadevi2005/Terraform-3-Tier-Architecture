variable "vpc_id" {
# Declaring input variable for module
  description = "VPC Id from other module"
  type        = string
}

variable "vpc_cidr" {
# Declaring input variable for module
  description = "VPC CIDR for RDS traffic"
  type        = list(string)
}