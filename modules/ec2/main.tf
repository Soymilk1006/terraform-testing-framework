

data "aws_region" "current" {

}


data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["al2023-ami-2023.*.*.0-kernel-*-x86_64"]

  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

}

data "aws_caller_identity" "current" {

}

data "aws_vpc" "my_vpc" {
  filter {
    name   = "owner-id"
    values = ["${data.aws_caller_identity.current.account_id}"]
  }

  filter {
    name   = "is-default"
    values = ["true"]
  }
}

data "aws_subnets" "subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.my_vpc.id]
  }

}


resource "aws_instance" "dev_test" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  subnet_id     = element(data.aws_subnets.subnets.ids, 0)
  tags = {
    "Name"          = "${var.instance_name}-${data.aws_region.current.name}"
    "Organization"  = "GVR"
    "Cost_Centre"   = "123"
    "Business_Unit" = "IT"
  }
}

