variable "vpc_cidr" {
# Declaring input variable for module
  description = "VPC CIDR Address"
  type        = string
  default     = "10.0.0.0/16"
}
variable "availability_zones" {
# Declaring input variable for module
  description = "Availabilty Zone 1"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}
variable "public_subnets_cidr" {
# Declaring input variable for module
  description = "Public subnet CIDR Address"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}
variable "private_app_subnets_cidr" {
# Declaring input variable for module
  description = "Public subnet CIDR Address"
  type        = list(string)
  default     = ["10.0.11.0/24", "10.0.12.0/24"]
}
variable "private_db_subnets_cidr" {
# Declaring input variable for module
  description = "Public subnet CIDR Address"
  type        = list(string)
  default     = ["10.0.21.0/24", "10.0.22.0/24"]
}
