aws_region           = "us-east-1"
project_name         = "tf-test-app"
environment          = "dev"
force_destroy_bucket = true

# Optional EC2 example
enable_ec2_example = true
instance_type      = "t3.micro"
ssh_allowed_cidr   = "0.0.0.0/0"
 