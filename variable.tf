variable "vpc_cidr" {
# Declaring input variable for module
  description = "VPC CIDR Address"
  type        = string
}
variable "availability_zones" {
# Declaring input variable for module
  description = "Availabilty Zone 1"
  type        = list(string)
}
variable "public_subnets_cidr" {
# Declaring input variable for module
  description = "Public subnet CIDR Address"
  type        = list(string)
}
variable "private_app_subnets_cidr" {
# Declaring input variable for module
  description = "Public subnet CIDR Address"
  type        = list(string)
}
variable "private_db_subnets_cidr" {
# Declaring input variable for module
  description = "Public subnet CIDR Address"
  type        = list(string)
}

variable "db_subnet_gp_name" {
# Declaring input variable for module
  description = "Database subnet group name"
  type = string
}
variable "key_name" {
# Declaring input variable for module
  description = "Jump Server Key -Value pair"
  type = string
}

variable "alb_name" {
# Declaring input variable for module
  description = "Application Load Balanacer Name"
  type = string
}

variable "lb_target_group_name" {
# Declaring input variable for module
  description = "Application Load Balanacer Target Group Name"
  type = string
}
variable "db_name" {
# Declaring input variable for module
  description = "Database Name"
  type = string
}
variable "db_identifier" {
# Declaring input variable for module
  description = "database DB identifier Name"
  type = string
}