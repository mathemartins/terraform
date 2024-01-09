output "hello_world" {
  description = "Print a simple hello world output"
  value       = "hello world"
}

output "vpc_id" {
  description = "Output the ID for the primary vpc"
  value       = aws_vpc.vpc.id
}

output "public_url" {
  description = "The web url to our server"
  value       = "https://${aws_instance.webserver.private_ip}:8080/index.html"
}

output "vpc_information" {
  description = "Your AWS environment VPC information"
  value       = "Your ${aws_vpc.vpc.tags.Environment} VPC has an ID: ${aws_vpc.vpc.id}"
}