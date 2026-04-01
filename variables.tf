variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project/app name prefix for resources"
  type        = string
  default     = "tf-test-app"
}

variable "environment" {
  description = "Environment label"
  type        = string
  default     = "dev"
}

variable "force_destroy_bucket" {
  description = "Allow deleting non-empty bucket (only for test/dev)"
  type        = bool
  default     = false
}

variable "enable_ec2_example" {
  description = "Enable EC2 + Security Group demo resources"
  type        = bool
  default     = false
}

variable "instance_type" {
  description = "EC2 instance type for demo"
  type        = string
  default     = "t3.micro"
}

variable "ssh_allowed_cidr" {
  description = "CIDR allowed to SSH to demo instance"
  type        = string
  default     = "0.0.0.0/0"
}

variable "vpc_id" {
  description = "Existing VPC ID to deploy into. If null, default VPC can be used when use_default_vpc=true."
  type        = string
  default     = null
}

variable "subnet_id" {
  description = "Subnet ID for EC2 demo instance. If null, first subnet in selected VPC is used."
  type        = string
  default     = null
}

variable "use_default_vpc" {
  description = "If true and vpc_id is null, use account default VPC."
  type        = bool
  default     = false
}
