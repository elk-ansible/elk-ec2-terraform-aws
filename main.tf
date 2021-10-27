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
#Elasticsearch Nodes
module "ec2_instance" {
  source                      = "terraform-aws-modules/ec2-instance/aws"
  version                     = "~> 3.0"
  associate_public_ip_address = true
  for_each                    = toset(["es01", "es02", "es03"])
  name                        = "tf-elk-${each.key}"
  ami                         = var.ami_image
  instance_type               = var.instance_type
  key_name                    = var.ssh_key
  monitoring                  = true
  vpc_security_group_ids      = [aws_security_group.elk_es_nodes.id, aws_security_group.allow_tls.id]
  subnet_id                   = aws_subnet.tf_main.id

  tags      = {
    Terraform   = "true"
    Environment = "dev"
  }
  user_data = "${file("user-data-apache.sh")}"
}

#Kibana node. We will also co-locate App-search,APM-server and Logstash on the same instance
resource "aws_instance" "kibana_server" {
  ami                         = var.ami_image
  instance_type               = "t3.large"
  subnet_id                   = aws_subnet.tf_main.id
  associate_public_ip_address = true
  key_name                    = var.ssh_key
  user_data = "${file("user-data-kibana.sh")}"
  tags                        = {
    Name        = "tf-elk-kibana"
    Terraform   = "true"
    Environment = "dev"
  }
  vpc_security_group_ids      = [
    aws_security_group.allow_tls.id,
    aws_security_group.elk_kibana.id,
    aws_security_group.elk_ent_search.id,
    aws_security_group.elk_apm_server.id,
    aws_security_group.elk_logstash.id
  ]
}

