variable "bastion_sg"{
# Declaring input variable for module
    type=string
}

variable "instance_sg"{
# Declaring input variable for module
    type=string
}

variable "target_group_arn"{
# Declaring input variable for module
    type=string
}

variable "bastion_subnet"{
# Declaring input variable for module
    type=string
}
variable "private_app_subnets"{
# Declaring input variable for module
    type=list(string)
}
variable "key_name" {
# Declaring input variable for module
  type = string
}
