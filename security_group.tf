data "aws_subnet" "instance_subnet" {
  id = var.subnet_id
}

data "aws_vpc" "instance_vpc" {
  id = data.aws_subnet.instance_subnet.vpc_id
}

resource "aws_security_group" "instance_created_security_group" {
  count  = var.create_security_group ? 1 : 0
  vpc_id = data.aws_subnet.instance_subnet.vpc_id
  tags = {
    "type" = "module-application-security-group"
  }
}

resource "aws_security_group_rule" "windows" {
  count = var.platform == "windows" ? 1 : 0
  type              = "ingress"
  from_port         = 3389
  protocol          = "tcp"
  cidr_blocks       = data.aws_vpc.instance_vpc.cidr_block
  security_group_id = aws_security_group.instance_created_security_group.id
  to_port = 3389
}

resource "aws_security_group_rule" "linux" {
  count = var.platform == "linux" ? 1 : 0
  from_port = 22
  protocol = "tcp"
  cidr_blocks = data.aws_vpc.instance_vpc.cidr_block
  security_group_id = aws_security_group.instance_created_security_group.id
  to_port = 22
  type = "ingress"
}

resource "aws_network_interface_sg_attachment" "sg_attachment" {
  count                = var.create_security_group ? 1 : 0
  security_group_id    = local.ec2_sg_id
  network_interface_id = aws_instance.ec2_module_instance.*.network_interface_id
}

resource "aws_network_interface_sg_attachment" "custom_sg_attachment" {
  count                = length(var.existing_security_group)
  security_group_id    = var.existing_security_group[count.index]
  network_interface_id = aws_instance.ec2_module_instance.*.network_interface_id
}
