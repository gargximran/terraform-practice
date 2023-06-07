
module "aws_alb" {
  source = "./aws_alb"
  region = var.default_region
}




module "ec2_vm" {
  source        = "./ec2_vm"
  region        = var.default_region
  ami           = "ami-0430580de6244e02e"
  instance_type = "t2.micro"
  instace_count = 2
  aws_alb_sg_id = module.aws_alb.aws_alb_sg_id
  tg_arn        = module.aws_alb.tg_arn
}