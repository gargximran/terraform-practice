
resource "aws_security_group" "security_group_01" {
  name = "http https allow security group"
  vpc_id = aws_vpc.test_vpc.id
  description = "allow for http and https ports"
  ingress {
    protocol  = "tcp"    
    from_port = 443
    to_port   = 443
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol  = "tcp"    
    from_port = 80
    to_port   = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol = "-1"
    from_port = 0
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}
