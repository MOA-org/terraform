data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_security_group" "demo_web_sg" {
  count       = var.enable_ec2_example ? 1 : 0
  name        = "${var.project_name}-${var.environment}-demo-web-sg"
  description = "Allow HTTP and SSH for demo instance"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh_allowed_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-${var.environment}-demo-web-sg"
  })
}

resource "aws_instance" "demo_web" {
  count                  = var.enable_ec2_example ? 1 : 0
  ami                    = data.aws_ami.amazon_linux_2023.id
  instance_type          = var.instance_type
  subnet_id              = data.aws_subnets.default.ids[0]
  vpc_security_group_ids = [aws_security_group.demo_web_sg[0].id]

  user_data = <<-EOT
    #!/bin/bash
    set -euxo pipefail
    dnf install -y httpd
    systemctl enable httpd
    echo "Hello from Terraform EC2 test app" > /var/www/html/index.html
    systemctl start httpd
  EOT

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-${var.environment}-demo-web"
  })
}
