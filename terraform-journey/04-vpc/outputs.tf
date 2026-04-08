output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_id" {
  description = "The ID of the public subnet"
  value       = aws_subnet.public.id
}

output "private_subnet_id" {
  description = "The ID of the private subnet"
  value       = aws_subnet.private.id
}

output "public_subnet_2_id" {
  description = "ID of the second public subnet (ap-south-1b)"
  value       = aws_subnet.public_2.id
}

output "internet_gateway_id" {
  description = "The ID of the Internet Gateway"
  value       = aws_internet_gateway.main.id
}

output "web_security_group_id" {
  description = "The ID of the web security group"
  value       = aws_security_group.web.id
}

output "ssh_security_group_id" {
  description = "The ID of the SSH security group"
  value       = aws_security_group.ssh.id
}

output "private_route_table_id" {
  description = "The ID of the private route table"
  value       = aws_route_table.private.id
}