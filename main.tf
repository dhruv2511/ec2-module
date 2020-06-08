locals {
  ami       = var.platform == "windows" ? "deep-windowsserver2016-" : "deep-amzn2-ami-hvm-"
  ec2_sg_id = concat(aws_security_group.instance_created_security_group.*.id, [""], )[0]
}

data "aws_ami" "ami" {
  most_recent = true
  owners      = ["630707141366"]

  filter {
    name   = "name"
    values = [local.ami]
  }
}

resource "aws_instance" "ec2_module_instance" {

  ami                  = data.aws_ami.ami.id
  instance_type        = var.instance_type
  user_data            = var.user_data
  key_name             = var.key_name
  security_groups      = [aws_security_group.instance_created_security_group.*.id]
  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name
  subnet_id            = var.subnet_id

  root_block_device {
    device_name           = data.aws_ami.ami.root_device_name
    volume_size           = var.root_volume_size
    delete_on_termination = true
    encrypted             = true
  }


  lifecycle {
    ignore_changes = [ami]
  }

  tags = merge(
    {
      "Name" = var.name
    },
    {
      "MaintenanceWindow" = var.maintenance_window
    },
    {
      "Backup_Plan" = var.backup_plan
    },
    {
      "Environment" = var.env
    },
    var.tags
  )

  volume_tags = merge(
    {
      "Name" = var.name
    },
    {
      "MaintenanceWindow" = var.maintenance_window
    },
    {
      "Environment" = var.env
    },
    var.volume_tags
  )

}

resource "aws_ssm_parameter" "ec2_password_data" {
  name        = var.name
  description = "The parameter description"
  type        = "SecureString"
  value       = aws_instance.ec2_module_instance.password_data
}

resource "aws_ebs_volume" "instances_ebs_volume" {
  for_each          = var.ebs_volume_device
  availability_zone = data.aws_subnet.instance_subnet.availability_zone
  encrypted         = true
  size              = lookup(var.ebs_volume_size)
  type              = "gp2"
}

resource "aws_volume_attachment" "instance_volume_attachment" {
  for_each    = var.ebs_volume_device
  device_name = lookup(var.ebs_block_device_name)
  instance_id = aws_instance.ec2_module_instance.id
  volume_id   = aws_ebs_volume.instances_ebs_volume.*.id
}
