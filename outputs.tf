output "aws_instance_public_dns" {
  value       = "http://${aws_instance.ubuntu.public_dns}"
  description = "Public DNS hostname of Ec2 instance"
}
