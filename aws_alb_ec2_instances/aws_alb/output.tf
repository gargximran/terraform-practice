output "aws_alb_sg_id" {
  value = aws_security_group.allow_http_from_all.id
}

output "tg_arn" {
  value = aws_lb_target_group.test_tg.arn
}