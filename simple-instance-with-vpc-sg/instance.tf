
resource "aws_instance" "test" {
    ami = "ami-0c4f7023847b90238"
    instance_type = "t2.micro"
    network_interface {
      network_interface_id = aws_network_interface.test_network.id
      device_index = 0
    }
}