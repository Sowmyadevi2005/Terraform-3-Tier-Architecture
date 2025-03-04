variable "alb_sg_id"{
# Declaring input variable for module
type = string
}

variable "vpc_id" {
# Declaring input variable for module
  type = string
}

variable "public_subnets" {
# Declaring input variable for module
  type = list(string)
}

variable "alb_name" {
# Declaring input variable for module
  type = string
}

variable "lb_target_group_name" {
# Declaring input variable for module
  type = string
}