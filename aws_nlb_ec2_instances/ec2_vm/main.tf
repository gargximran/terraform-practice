
resource "aws_security_group" "allow_http" {
  name = "http_allow_from_all"
  description = "allow http for vms"

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
  
}





resource "aws_instance" "child_vm" {
  ami           = var.ami
  instance_type = var.instance_type
  user_data = file(abspath("ec2_vm/script.sh"))
  vpc_security_group_ids = [aws_security_group.allow_http.id]
  count = var.instace_count
  tags = {
    Name = "ChildVM-${count.index}"
  }
}




resource "aws_lb_target_group_attachment" "test_attachment" {

  for_each = { for index, instance in aws_instance.child_vm : index => instance }
  target_group_arn = var.tg_arn
  target_id        = each.value.id
  port             = 80
}





