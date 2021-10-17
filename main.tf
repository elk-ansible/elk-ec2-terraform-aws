terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "us-west-2"
}

#resource "aws_instance" "app_server" {
#  ami           = var.ami_image
#  instance_type = var.instance_type
#  subnet_id = aws_subnet.tf_main.id
#associate_public_ip_address = true
#  tags = {
#    Name = var.instance_name
#  }
#  vpc_security_group_ids  = [aws_security_group.allow_tls.id]
#}
module "ec2_instance" {
  source                      = "terraform-aws-modules/ec2-instance/aws"
  version                     = "~> 3.0"
  associate_public_ip_address = true
  for_each                    = toset(["es01", "es02", "es03"])

  name                   = "tf-elk-node-${each.key}"
  ami                    = var.ami_image
  instance_type          = var.instance_type
  #  key_name               = "user1"
  monitoring             = true
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  subnet_id              = aws_subnet.tf_main.id

  tags      = {
    Terraform   = "true"
    Environment = "dev"
  }
  user_data = "${file("user-data-apache.sh")}"

}


resource "aws_route53_zone" "example" {
  name = "test.dfh.ai"
  vpc {
    vpc_id = aws_vpc.tf_main.id
  }
}


resource "aws_route53_record" "www" {
  zone_id  = aws_route53_zone.example.zone_id
  for_each = toset(["es01", "es02", "es03"])
  name     = "${each.key}"
  type     = "A"
  ttl      = "300"
  records  = [module.ec2_instance[each.key].private_ip]
}

