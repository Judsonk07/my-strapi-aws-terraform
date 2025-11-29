output "strapi_public_ip" {
  description = "Public IP of Strapi EC2 instance"
  value       = aws_instance.strapi_ec2.public_ip
}

output "strapi_url" {
  description = "URL to access Strapi (port 1337)"
  value       = "http://${aws_instance.strapi_ec2.public_dns}:1337"
}
