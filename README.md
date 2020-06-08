## Requirements


Confirming AMI Usage in within PMI standard
Dedicated Security Groups
Mandatory Tags for example MaintenanceWindow, Env and BackUp Plan
Instance Role assignment with SSM permissions


## Introduction

To meet the above requirement I have created a simple module with different configuration and some mandatory field.
Having resources to manage IAM and Security Groups. Also, filtering AMI using account ID as those will be standard images
which PMI supports. 


## Usage 

An example on how the module can be used within an application:

```hcl-terraform
module "ec2" {
  source = ""
  name = "example_ec2_instance"
  ami_name = "windows"
  instance_type = "instance_type"
  create_security_group = true
  ec2_security_group_name = "security_group_name"

  backup_plan = "example_backup_plan"

  maintenance_window = "example_maintenancewindow"

  env = "dev"

  subnet_id = "example_subnet_id"
  

  ebs_block_device = [{
    device_name = "example_ebs_device_name"
    volume_size = 30
  }]
}
```
## Mandatory Tags 

### backup\_plan

Description: A tag for back up plan that needs to be specified

Type: `string`

### env

Description: Environment for the EC2 Instance

Type: `string`

### maintenance\_window

Description: Specifying maintenance window for the EC2 Instance

Type: `string`

## Below are all the module necessities.

## Providers

The following providers are used by this module:

- aws

## Required Inputs

The following input variables are required:

### backup\_plan

Description: A tag for back up plan that needs to be specified

Type: `string`

### env

Description: Environment for the EC2 Instance

Type: `string`

### instance\_type

Description: The type of instance to start

Type: `string`

### maintenance\_window

Description: Specifying maintenance window for the EC2 Instance

Type: `string`

### name

Description: Name to be used on all resources as prefix

Type: `string`

### subnet\_id

Description: The VPC Subnet ID to launch in

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### ami\_name

Description: Name of AMI to use for the instance, give windows or linux as a value

Type: `string`

Default: `"windows"`

### create\_security\_group

Description: To create a new security group set this to true

Type: `bool`

Default: `false`

### ebs\_block\_device

Description: Additional EBS block devices to attach to the instance

Type: `list(map(string))`

Default: `[]`

### ec2\_security\_group\_name

Description: Name of security group to create

Type: `string`

Default: `"ec2_module_instance_security_group"`

### existing\_security\_group

Description: Specify a security group id that the instance should have

Type: `list(string)`

Default: `[]`

### iam\_policy\_arn

Description: List of policies to be assigned to the EC2 Instance

Type: `list(string)`

Default: `[]`

### instance\_count

Description: Number of instances to launch

Type: `number`

Default: `1`

### instance\_profile\_name

Description: The IAM Instance Profile to launch the instance with. Specified as the name of the Instance Profile.

Type: `string`

Default: `""`

### network\_interface

Description: Customize network interfaces to be attached at instance boot time

Type: `list(map(string))`

Default: `[]`

### role\_name

Description: A role name that needs to be given for EC2 instance to have access to SSM store

Type: `string`

Default: `""`

### root\_block\_device\_name

Description: Name to be give to the root block device of the instance.

Type: `string`

Default: `"ec2_module_root_block_device"`

### root\_block\_device\_volume\_size

Description: Volume size for the root block device of the instance

Type: `number`

Default: `"5"`

### subnet\_ids

Description: A list of VPC Subnet IDs to launch in

Type: `list(string)`

Default: `[]`

### tags

Description: A mapping of tags to assign to the resource

Type: `map(string)`

Default: `{}`

### use\_num\_suffix

Description: Always append numerical suffix to instance name, even if instance\_count is 1

Type: `bool`

Default: `false`

### user\_data

Description: The user data to provide when launching the instance. Do not pass gzip-compressed data via this argument; see user\_data\_base64 instead.

Type: `string`

Default: `"default"`

### volume\_tags

Description: A mapping of tags to assign to the devices created by the instance at launch time

Type: `map(string)`

Default: `{}`

## Outputs

The following outputs are exported:

### arn

Description: List of ARNs of instances

### id

Description: List of IDs of instances

### instance\_count

Description: Number of instances to launch specified as argument to this module

### instance\_state

Description: List of instance states of instances

### security\_groups

Description: List of associated security groups of instances

### tags

Description: List of tags of instances

### volume\_tags

Description: List of tags of volumes of instances

