variable "region_name" {
  description = "Region name"
  type        = string
  default     = "ap-southeast-1"

}


variable "instance_name" {

  description = "Ec2 Instance Name"
  type        = string
  validation {
    condition     = can(regex("_", var.instance_name))
    error_message = "The name value must have underscore '_' in it."
  }
}

variable "instance_type" {
  description = "ec2 instance type"
  type        = string
  validation {
    condition     = can(regex("\\.", var.instance_type))
    error_message = "The name of ec2 instance type must have a dot '.' in it"
  }
}
