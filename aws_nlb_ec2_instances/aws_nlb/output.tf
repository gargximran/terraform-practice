output "tg_arn" {
  value = aws_lb_target_group.test_tg.arn
}

output "nlb_dns_name" {
  value = aws_lb.test_nlb.dns_name
}
