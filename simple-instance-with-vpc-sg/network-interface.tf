resource "aws_network_interface" "test_network" {
    subnet_id = aws_subnet.test_subnet.id
    private_ips = ["172.16.10.13"]
    security_groups = [aws_security_group.security_group_01.id]
}