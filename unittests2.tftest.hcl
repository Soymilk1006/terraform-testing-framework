#6 sixth
run "ec2_ami_check" {
  command = plan

  assert {
    condition     = module.ec2.ami_Id == "ami-0cc78e72c287beef1"
    error_message = "TEST_ERROR: AMI is wrong"
  }
}
