output "vpc_id" {
# Outputting resource attribute
  value = aws_vpc.vpc.id
}

output "vpc_cidr" {
# Outputting resource attribute
  value = var.vpc_cidr
}
output "public_subnets" {
# Outputting resource attribute
  value = aws_subnet.public_subnets[*].id
}

output "private_app_subnets" {
# Outputting resource attribute
  value = aws_subnet.private_app_subnets[*].id
}

output "private_db_subnets" {
# Outputting resource attribute
  value = aws_subnet.private_db_subnets[*].id
}