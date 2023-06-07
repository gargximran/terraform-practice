resource "aws_security_group" "allow_http_from_all" {
  name = "http_allow_from_all_for_alb"
  description = "allow http for ALB"

  ingress {
    description      = "TLS from VPC"
    from_port        = 80
    to_port          = 80
    cidr_blocks = ["0.0.0.0/0"]
    protocol         = "tcp"
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    ALB_SG = "AWS_TEST_LB_SG"
  }
  
}

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


resource "aws_lb" "test_alb" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_http_from_all.id]
  subnets = [aws_default_subnet.us-east-2a.id, aws_default_subnet.us-east-2b.id]
  enable_deletion_protection = false


  tags = {
    Environment = "test"
  }
}


resource "aws_lb_target_group" "test_tg" {
  name     = "tf-example-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id = aws_default_vpc.default.id
}



resource "aws_lb_listener" "test_ln" {
  load_balancer_arn = aws_lb.test_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.test_tg.arn
  }
}