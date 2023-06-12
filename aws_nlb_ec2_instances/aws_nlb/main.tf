

resource "aws_default_subnet" "us-east-2a" {
  availability_zone = "us-east-2a"

}

resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

resource "aws_default_subnet" "us-east-2b" {
  availability_zone = "us-east-2b"

}


resource "aws_lb" "test_nlb" {
  name               = "test-nlb-tf"
  internal           = false
  ip_address_type    = "ipv4"
  load_balancer_type = "network"
  subnets = [aws_default_subnet.us-east-2a.id, aws_default_subnet.us-east-2b.id]
  enable_deletion_protection = false

}


resource "aws_lb_target_group" "test_tg" {
  name     = "tf-example-lb-tg"
  port     = 80
  protocol = "TCP"
  vpc_id = aws_default_vpc.default.id
}



resource "aws_lb_listener" "test_ln" {
  load_balancer_arn = aws_lb.test_nlb.arn
  port              = "80"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.test_tg.arn
  }
}