# LB DNS name
output "dns_name" {
  description = "The DNS name of the load balancer."
  value       = aws_lb.LB1.dns_name
}

output "end_point" {
  value = aws_db_instance.mariadb.endpoint
}