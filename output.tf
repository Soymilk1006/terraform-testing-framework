output "image_id" {
  value = module.ec2.image_id
}

output "vpc_id" {
  value = module.ec2.vpc_id

}

output "subnet_ids" {
  value = module.ec2.subnet_ids

}

output "ec2_Instance_details" {
  value = module.ec2.ec2_instance_details

}

output "ec2_instance_tags" {
  value = module.ec2.ec2_instance_tags
}

output "ami_Id" {
  value = module.ec2.ami_Id
}

#--------------------
output "ec2_output" {
  value = module.ec2
}

output "ec2_created_for" {
  value = "DEMO"
}
