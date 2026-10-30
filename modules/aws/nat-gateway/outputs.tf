output "id" {
  description = "ID of the NAT Gateway."
  value       = aws_nat_gateway.this.id
}

output "public_ip" {
  description = "The public IPv4 address of the NAT Gateway."
  value       = aws_nat_gateway.this.public_ip
}