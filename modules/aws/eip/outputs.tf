output "id" {
  description = "EIP allocation ID."
  value       = aws_eip.this.id
}

output "public_ip" {
  description = "The public IPv4 address assigned to the EIP."
  value       = aws_eip.this.public_ip
}