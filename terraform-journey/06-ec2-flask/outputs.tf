output "flask_app_public_ip" {
  description = "Public IP of the Flask EC2 instance"
  value       = aws_instance.flask_app.public_ip
}

output "flask_app_url" {
  description = "URL to access the Flask app"
  value       = "http://${aws_instance.flask_app.public_ip}"
}