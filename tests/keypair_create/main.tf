terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.52.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = var.region_name
}

variable "region_name" {
  type = string
}

variable "keypair_name" {
  type = string
}

resource "tls_private_key" "dev" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "local_file" "key" {
  content  = tls_private_key.dev.private_key_pem
  filename = "${path.module}/${var.keypair_name}.pem"

}

resource "aws_key_pair" "dev" {
  key_name   = var.keypair_name
  public_key = tls_private_key.dev.public_key_openssh
}
