variable "name" {
  description = "Name to be used on all resources as prefix"
  type        = string
}

variable "instance_count" {
  description = "Number of instances to launch"
  type        = number
  default     = 1
}

variable "platform" {
  description = "Name of AMI to use for the instance, give windows or linux as a value"
  type        = string
  default     = "windows"
}

variable "instance_type" {
  description = "The type of instance to start"
  type        = string
}

variable "ec2_security_group_name" {
  description = "Name of security group to create"
  type        = string
  default     = "ec2_module_instance_security_group"
}

variable "user_data" {
  description = "The user data to provide when launching the instance. Do not pass gzip-compressed data via this argument; see user_data_base64 instead."
  type        = string
  default     = ""
}

variable "instance_profile_name" {
  description = "The IAM Instance Profile to launch the instance with. Specified as the name of the Instance Profile."
  type        = string
  default     = ""
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "volume_tags" {
  description = "A mapping of tags to assign to the devices created by the instance at launch time"
  type        = map(string)
  default     = {}
}

variable "create_security_group" {
  description = "To create a new security group set this to true"
  type        = bool
  default     = false
}

variable "existing_security_group" {
  description = "Specify a security group id that the instance should have"
  type        = list(string)
  default     = []
}

variable "iam_policy_arn" {
  description = "List of policies to be assigned to the EC2 Instance"
  type        = list(string)
  default     = []
}

variable "backup_plan" {
  description = "A tag for back up plan that needs to be specified"
  type        = string
  default = "default"
}

variable "env" {
  description = "Environment for the EC2 Instance"
  type        = string
}

variable "maintenance_window" {
  description = "Specifying maintenance window for the EC2 Instance"
  type        = string
}

variable "subnet_id" {
  description = "The VPC Subnet ID to launch in"
  type        = string
}

variable "subnet_ids" {
  description = "A list of VPC Subnet IDs to launch in"
  type        = list(string)
  default     = []
}

variable "key_name" {
  description = "The key name to use for the instance"
}

variable "root_volume_size" {
  description = "Volume size for the root block device of the instance"
  type        = number
  default     = "30"
}

variable "ebs_block_device_name" {
  description = "Additional EBS block devices to attach to the instance"
  type        = string
}

variable "ebs_volume_size" {
  description = "EBS volume size that needs to be attached to the instance"
  type = number
}

variable "ebs_volume_device" {
  description = "EBS volumes to be created that needs to be attached to the instance"
  type = list
  default = []
}

