
module "aws_nlb" {
  source = "./aws_nlb"
  region = var.default_region
}


module "ec2_vm" {
  source        = "./ec2_vm"
  region        = var.default_region
  ami           = "ami-0430580de6244e02e"
  instance_type = "t2.micro"
  instace_count = 2
  tg_arn        = module.aws_nlb.tg_arn
}


output "dns_name" {
  value = module.aws_nlb.nlb_dns_name
}