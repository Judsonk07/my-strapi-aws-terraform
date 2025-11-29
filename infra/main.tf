# ------------------------------
# Default VPC & Subnets
# ------------------------------
data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# ------------------------------
# Amazon Linux 2023 AMI
# ------------------------------
data "aws_ami" "amz_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  owners = ["137112412989"] # Amazon
}

# ------------------------------
# SSH key pair
# ------------------------------
resource "aws_key_pair" "strapi_key" {
  key_name   = "strapi-key-terraform"
  public_key = file(var.public_key_path)
}

# ------------------------------
# Security group (SSH + Strapi port)
# ------------------------------
resource "aws_security_group" "strapi_sg" {
  name        = "strapi-sg"
  description = "Security group for Strapi EC2 instance"
  vpc_id      = data.aws_vpc.default.id

  # SSH
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Strapi HTTP (port 1337)
  ingress {
    description = "Strapi HTTP"
    from_port   = 1337
    to_port     = 1337
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "All outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# ------------------------------
# EC2 instance (Amazon Linux 2023)
# ------------------------------
resource "aws_instance" "strapi_ec2" {
  ami                         = data.aws_ami.amz_linux.id
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.strapi_key.key_name
  vpc_security_group_ids      = [aws_security_group.strapi_sg.id]
  subnet_id                   = data.aws_subnets.default_subnets.ids[0]
  associate_public_ip_address = true

  # Bigger disk so node_modules fit
  root_block_device {
    volume_size = 30
    volume_type = "gp3"
  }

  tags = {
    Name = "strapi-ec2"
  }
}
