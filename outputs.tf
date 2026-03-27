output "bucket_name" {
  description = "Name of the test bucket"
  value       = aws_s3_bucket.app_bucket.bucket
}

output "bucket_arn" {
  description = "ARN of the test bucket"
  value       = aws_s3_bucket.app_bucket.arn
}

output "region" {
  description = "Deployment region"
  value       = var.aws_region
}

output "ec2_public_ip" {
  description = "Public IP of demo EC2 instance (null when disabled)"
  value       = try(aws_instance.demo_web[0].public_ip, null)
}

output "ec2_public_dns" {
  description = "Public DNS of demo EC2 instance (null when disabled)"
  value       = try(aws_instance.demo_web[0].public_dns, null)
}
