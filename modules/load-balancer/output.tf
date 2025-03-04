output "target_group_arn" {
# Outputting resource attribute
  value = aws_lb_target_group.tg.arn
}

output "dns_name" {
# Outputting resource attribute
  value = aws_lb.app_lb.dns_name

}