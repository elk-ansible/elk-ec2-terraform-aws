variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "ExampleAppServerInstance"
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