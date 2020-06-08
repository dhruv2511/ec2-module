output "id" {
  description = "List of IDs of instances"
  value       = aws_instance.ec2_module_instance.*.id
}

output "arn" {
  description = "List of ARNs of instances"
  value       = aws_instance.ec2_module_instance.*.arn
}

output "security_groups" {
  description = "List of associated security groups of instances"
  value       = aws_instance.ec2_module_instance.*.security_groups
}

output "instance_state" {
  description = "List of instance states of instances"
  value       = aws_instance.ec2_module_instance.*.instance_state
}

output "tags" {
  description = "List of tags of instances"
  value       = aws_instance.ec2_module_instance.*.tags
}

output "volume_tags" {
  description = "List of tags of volumes of instances"
  value       = aws_instance.ec2_module_instance.*.volume_tags
}

output "private_ip" {
  description = "Private IP for the instance"
  value = aws_instance.ec2_module_instance.private_ip
}

output "password_parameter" {
  description = "Password Data from the instance is stored in secure string under SSM"
  value = aws_ssm_parameter.ec2_password_data.name
}