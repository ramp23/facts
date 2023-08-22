output "vpc_id" {
  value       = aws_vpc.main.id
  description = "Main VPC id."
  sensitive   = false
}