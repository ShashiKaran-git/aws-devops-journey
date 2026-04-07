output "nat_gateway_id" {
  description = "The ID of the NAT Gateway"
  value       = aws_nat_gateway.main.id
}

output "nat_gateway_public_ip" {
  description = "The public IP of the NAT Gateway"
  value       = aws_eip.nat.public_ip
}
