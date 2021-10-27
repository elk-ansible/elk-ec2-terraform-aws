variable "env_name" {
  description = "Environment Name DEV, UAT, PROD"
  type        = string
  default     = "dev"
}
variable "region" {
  description = "AWS Region"
  type = string
  default = "us-east-1"
}

variable "ami_image" {
  description = "AMI image to use for deployment"
  type = string
  default = "ami-013a129d325529d4d"
}

variable "instance_type" {
  type = string
  default = "c5d.large"
}


variable "ssh_key" {
  type = string
  default = "id_rsa"
}

variable "domain_name" {
  type = string
  default = "example.com"
}