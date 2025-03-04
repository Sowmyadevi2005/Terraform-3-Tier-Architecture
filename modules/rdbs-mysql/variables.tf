variable "rds_sg_id" {
# Declaring input variable for module
  type = string
}
variable "db_subnets" {
# Declaring input variable for module
  type = list(string)
}

variable "db_subnet_gp_name" {
# Declaring input variable for module
  type = string
}

variable "db_name" {
# Declaring input variable for module
 type = string 
}

variable "db_identifier" {
# Declaring input variable for module
  type = string
}