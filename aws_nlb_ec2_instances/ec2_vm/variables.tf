variable "region" {
  description = "AWS region"
  type        = string
}

variable "ami" {
    description = "AMI id for VMS"
    type = string
}

variable "instance_type" {
    description = "Instance Type for AWS instace"
    type = string
}

variable "instace_count" {
  type = number
}


variable "tg_arn" {
  type = string
}