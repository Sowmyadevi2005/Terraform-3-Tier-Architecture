output "alb_sg_id" {
# Outputting resource attribute
  value = aws_security_group.alb_sg.id
}
output "bastion_sg_id" {
# Outputting resource attribute
  value = aws_security_group.bastion_sg.id
}
output "instance_sg_id" {
# Outputting resource attribute
  value = aws_security_group.instance_sg.id
}
output "rds_sg_id" {
# Outputting resource attribute
  value = aws_security_group.rds_sg.id
}