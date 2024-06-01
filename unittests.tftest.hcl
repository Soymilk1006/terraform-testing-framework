variables {
  global_var_org = "GVR"
  global_cc      = "123"
  global_bu      = "IT"
}


run "validate_inputs" {
  command = plan
  variables {


    instance_name = "devinstance99"
    instance_type = "t2micro"
    region_name   = "ap-southeast-1"
  }

  expect_failures = [
    var.instance_name,
    var.instance_type

  ]
}

#2 unit testing
run "name_validation" {
  command = plan


  assert {
    condition     = module.ec2.ec2_instance_tags["Name"] == "${var.instance_name}-${var.region_name}"
    error_message = "TEST_ERROR: Instance name is not as expected"
  }
}


run "org_validation" {
  command = plan
  assert {
    condition     = module.ec2.ec2_instance_tags["Organization"] == var.global_var_org
    error_message = "TEST_ERROR: Instance name is not as expected"
  }
}

# Customized provider

provider "aws" {
  alias  = "singapore"
  region = "ap-southeast-1"
}

run "customised_provider_singapore" {
  command = plan

  providers = {
    aws = aws.singapore
  }

  assert {
    condition     = module.ec2.ec2_instance_tags["Name"] == "${var.instance_name}-ap-southeast-1"
    error_message = "TEST_ERROR: Instance name is not as expected"
  }
}


# modules - Integration Testing
run "create_key_pair" {
  module {
    source = "./tests/keypair_create"
  }
}

run "lookup_verify_key_pair" {
  module {
    source = "./tests/keypair_lookup"
  }

  assert {
    condition     = data.aws_key_pair.this.key_name == var.keypair_name
    error_message = "Key pair name is wrong"
  }


}


run "check_Name_validation_call" {
  assert {
    condition     = run.name_validation.ec2_created_for == "DEMO"
    error_message = "TEST_ERROR: Created for is wrong"
  }
}
